package com.biblio.controller;

import com.biblio.domain.Adherent;
import com.biblio.domain.Emprunt;
import com.biblio.domain.Livre;
import com.biblio.service.AdherentService;
import com.biblio.service.EmpruntService;
import com.biblio.service.LivreService;
import javafx.scene.control.Alert;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TableRow;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.util.StringConverter;
import com.biblio.util.EventBus;
import com.biblio.security.Session;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

public class EmpruntController {
    @FXML
    private ComboBox<Livre> cbLivre;
    @FXML
    private ComboBox<Adherent> cbAdherent;
    @FXML
    private DatePicker dpDateLimite;
    @FXML
    private TableView<Emprunt> tableEmprunts;
    @FXML
    private TableColumn<Emprunt, String> colLivre;
    @FXML
    private TableColumn<Emprunt, String> colAdherent;
    @FXML
    private TableColumn<Emprunt, LocalDate> colDateLimite;
    @FXML
    private TableColumn<Emprunt, String> colStatut;
    @FXML
    private TableColumn<Emprunt, String> colPenalite;

    private final EmpruntService empruntService = new EmpruntService();
    private final LivreService livreService = new LivreService();
    private final AdherentService adherentService = new AdherentService();
    private final ObservableList<Emprunt> data = FXCollections.observableArrayList();

    @FXML
    public void initialize() {
        cbLivre.setConverter(new StringConverter<>() {
            @Override
            public String toString(Livre livre) {
                return livre == null ? "" : livre.getTitre();
            }
            @Override
            public Livre fromString(String string) {
                return null;
            }
        });
        cbAdherent.setConverter(new StringConverter<>() {
            @Override
            public String toString(Adherent a) {
                return a == null ? "" : a.getNom() + " " + a.getPrenom();
            }
            @Override
            public Adherent fromString(String string) {
                return null;
            }
        });
        cbLivre.setItems(FXCollections.observableArrayList(livreService.findAll()));
        cbAdherent.setItems(FXCollections.observableArrayList(adherentService.findAll()));

        colLivre.setCellValueFactory(cell -> new SimpleStringProperty(cell.getValue().getLivre().getTitre()));
        colAdherent.setCellValueFactory(cell -> {
            Adherent a = cell.getValue().getAdherent();
            return new SimpleStringProperty(a.getNom() + " " + a.getPrenom());
        });
        colDateLimite.setCellValueFactory(new PropertyValueFactory<>("dateRetourPrevue"));
        if (colStatut != null) {
            colStatut.setCellValueFactory(cell -> {
                Emprunt em = cell.getValue();
                if (em.getDateRetourEffective() != null) {
                    return new javafx.beans.property.SimpleStringProperty("Terminé");
                }
                boolean overdue = em.getDateRetourPrevue() != null
                        && LocalDate.now().isAfter(em.getDateRetourPrevue());
                return new javafx.beans.property.SimpleStringProperty(overdue ? "En retard ⚠" : "En cours");
            });
        }
        if (colPenalite != null) {
            colPenalite.setCellValueFactory(cell -> {
                Integer m = cell.getValue().getMontantPenalite();
                String txt = (m == null || m == 0) ? "0 FCFA" : (m + " FCFA");
                return new javafx.beans.property.SimpleStringProperty(txt);
            });
        }

        data.setAll(empruntService.findAll());
        tableEmprunts.setItems(data);
        tableEmprunts.setRowFactory(tv -> new TableRow<>() {
            @Override
            protected void updateItem(Emprunt item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null) {
                    setStyle("");
                } else {
                    boolean overdue = item.getDateRetourEffective() == null
                            && item.getDateRetourPrevue() != null
                            && LocalDate.now().isAfter(item.getDateRetourPrevue());
                    setStyle(overdue ? "-fx-background-color: #ffe6e6;" : "");
                }
            }
        });
    }

    @FXML
    private void onEnregistrer() {
        Livre livre = cbLivre.getValue();
        Adherent adh = cbAdherent.getValue();
        LocalDate limite = dpDateLimite.getValue();
        if (livre == null || adh == null) {
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.setHeaderText(null);
            alert.setTitle("Sélection requise");
            alert.setContentText("Veuillez choisir un livre et un adhérent.");
            alert.showAndWait();
            return;
        }
        if (limite == null) {
            limite = LocalDate.now().plusDays(14);
        }
        if (!adh.isActif()) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setHeaderText(null);
            alert.setTitle("Adhérent suspendu");
            alert.setContentText("Cet adhérent est suspendu. Réactivez son compte pour emprunter.");
            alert.showAndWait();
            return;
        }
        if (livre.getExemplairesDisponibles() <= 0) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Stock insuffisant");
            alert.setHeaderText(null);
            alert.setContentText("Ce livre n'est plus disponible en stock.");
            alert.showAndWait();
            return;
        }
        Emprunt e = new Emprunt();
        e.setLivre(livre);
        e.setAdherent(adh);
        e.setDateEmprunt(LocalDate.now());
        e.setDateRetourPrevue(limite);
        if (Session.getCurrentUser() != null) {
            e.setUtilisateur(Session.getCurrentUser());
        }
        try {
            empruntService.add(e);
        } catch (RuntimeException ex) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Erreur d'emprunt");
            alert.setHeaderText(null);
            alert.setContentText(ex.getMessage());
            alert.showAndWait();
            return;
        }
        data.add(e);
        EventBus.post("STOCK_UPDATED");
        cbLivre.setValue(null);
        cbAdherent.setValue(null);
        dpDateLimite.setValue(null);
    }

    @FXML
    private void onMarquerRetour() {
        Emprunt selected = tableEmprunts.getSelectionModel().getSelectedItem();
        if (selected == null) {
            return;
        }
        empruntService.enregistrerRetour(selected);
        data.setAll(empruntService.findAll());
        tableEmprunts.refresh();
        EventBus.post("STOCK_UPDATED");
        Integer m = selected.getMontantPenalite();
        String msg = (m != null && m > 0)
                ? "Retour enregistré.\nPénalité: " + m + " FCFA."
                : "Retour enregistré.";
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle("Retour enregistré");
        alert.setHeaderText(null);
        alert.setContentText(msg);
        alert.showAndWait();
    }
}
