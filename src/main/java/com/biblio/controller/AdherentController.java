package com.biblio.controller;

import com.biblio.domain.Adherent;
import com.biblio.service.AdherentService;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import com.biblio.service.EmpruntService;
import com.biblio.domain.Emprunt;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.SimpleObjectProperty;

public class AdherentController {
    @FXML
    private TableView<Adherent> tableAdherents;
    @FXML
    private TableColumn<Adherent, String> colNom;
    @FXML
    private TableColumn<Adherent, String> colPrenom;
    @FXML
    private TableColumn<Adherent, String> colEmail;
    @FXML
    private TableColumn<Adherent, String> colTelephone;
    @FXML
    private TextField txtNom;
    @FXML
    private TextField txtPrenom;
    @FXML
    private TextField txtEmail;
    @FXML
    private TextField txtTelephone;
    @FXML
    private TableView<Emprunt> tableHistorique;
    @FXML
    private TableColumn<Emprunt, String> colHLivre;
    @FXML
    private TableColumn<Emprunt, java.time.LocalDate> colHDateEmp;
    @FXML
    private TableColumn<Emprunt, java.time.LocalDate> colHDateLimite;
    @FXML
    private TableColumn<Emprunt, java.time.LocalDate> colHDateRetour;
    @FXML
    private TableColumn<Emprunt, String> colHPenalite;
    @FXML
    private TableColumn<Emprunt, String> colHStatut;

    private final AdherentService adherentService = new AdherentService();
    private final ObservableList<Adherent> data = FXCollections.observableArrayList();
    private final EmpruntService empruntService = new EmpruntService();
    private final ObservableList<Emprunt> histoData = FXCollections.observableArrayList();

    @FXML
    public void initialize() {
        colNom.setCellValueFactory(new PropertyValueFactory<>("nom"));
        colPrenom.setCellValueFactory(new PropertyValueFactory<>("prenom"));
        colEmail.setCellValueFactory(new PropertyValueFactory<>("email"));
        colTelephone.setCellValueFactory(new PropertyValueFactory<>("telephone"));
        data.setAll(adherentService.findAll());
        tableAdherents.setItems(data);
        tableAdherents.getSelectionModel().selectedItemProperty().addListener((obs, oldSel, newSel) -> {
            if (newSel != null) {
                txtNom.setText(newSel.getNom());
                txtPrenom.setText(newSel.getPrenom());
                txtEmail.setText(newSel.getEmail());
                txtTelephone.setText(newSel.getTelephone());
                refreshHistorique(newSel);
            }
        });
        if (tableHistorique != null) {
            tableHistorique.setItems(histoData);
            if (colHLivre != null) {
                colHLivre.setCellValueFactory(cell -> {
                    var l = cell.getValue().getLivre();
                    return new SimpleStringProperty(l == null ? "" : l.getTitre());
                });
            }
            if (colHDateEmp != null) colHDateEmp.setCellValueFactory(cell -> new SimpleObjectProperty<>(cell.getValue().getDateEmprunt()));
            if (colHDateLimite != null) colHDateLimite.setCellValueFactory(cell -> new SimpleObjectProperty<>(cell.getValue().getDateRetourPrevue()));
            if (colHDateRetour != null) colHDateRetour.setCellValueFactory(cell -> new SimpleObjectProperty<>(cell.getValue().getDateRetourEffective()));
            if (colHPenalite != null) {
                colHPenalite.setCellValueFactory(cell -> {
                    Integer m = cell.getValue().getMontantPenalite();
                    String txt = (m == null || m == 0) ? "0" : String.valueOf(m);
                    return new SimpleStringProperty(txt);
                });
            }
            if (colHStatut != null) {
                colHStatut.setCellValueFactory(cell -> {
                    Emprunt e = cell.getValue();
                    boolean termine = e.getDateRetourEffective() != null;
                    boolean retard = !termine && e.getDateRetourPrevue() != null && java.time.LocalDate.now().isAfter(e.getDateRetourPrevue());
                    return new SimpleStringProperty(termine ? "Terminé" : (retard ? "En retard" : "En cours"));
                });
            }
        }
    }

    @FXML
    private void onAdd() {
        String nom = txtNom.getText();
        String prenom = txtPrenom.getText();
        String email = txtEmail.getText();
        String tel = txtTelephone.getText();
        if (isBlank(nom) || isBlank(prenom) || isBlank(email)) {
            return;
        }
        Adherent a = new Adherent();
        a.setNom(nom.trim());
        a.setPrenom(prenom.trim());
        a.setEmail(email.trim());
        a.setTelephone(isBlank(tel) ? null : tel.trim());
        adherentService.add(a);
        data.add(a);
        clearForm();
    }

    @FXML
    private void onUpdate() {
        Adherent selected = tableAdherents.getSelectionModel().getSelectedItem();
        if (selected == null) return;
        String nom = txtNom.getText();
        String prenom = txtPrenom.getText();
        String email = txtEmail.getText();
        String tel = txtTelephone.getText();
        if (isBlank(nom) || isBlank(prenom) || isBlank(email)) {
            return;
        }
        selected.setNom(nom.trim());
        selected.setPrenom(prenom.trim());
        selected.setEmail(email.trim());
        selected.setTelephone(isBlank(tel) ? null : tel.trim());
        adherentService.update(selected);
        tableAdherents.refresh();
        refreshHistorique(selected);
    }

    @FXML
    private void onDelete() {
        Adherent selected = tableAdherents.getSelectionModel().getSelectedItem();
        if (selected == null) return;
        Alert confirm = new Alert(Alert.AlertType.CONFIRMATION, "Supprimer cet adhérent ?", ButtonType.OK, ButtonType.CANCEL);
        confirm.setHeaderText(null);
        var res = confirm.showAndWait();
        if (res.isEmpty() || res.get() != ButtonType.OK) {
            return;
        }
        adherentService.delete(selected);
        data.remove(selected);
        clearForm();
        histoData.clear();
        tableHistorique.refresh();
    }
 
    @FXML
    private void onToggleActive() {
        Adherent selected = tableAdherents.getSelectionModel().getSelectedItem();
        if (selected == null) return;
        selected.setActif(!selected.isActif());
        adherentService.update(selected);
        tableAdherents.refresh();
    }

    private void clearForm() {
        txtNom.clear();
        txtPrenom.clear();
        txtEmail.clear();
        txtTelephone.clear();
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
 
    private void refreshHistorique(Adherent a) {
        if (a == null || tableHistorique == null) return;
        histoData.setAll(empruntService.findByAdherentId(a.getId()));
        tableHistorique.refresh();
    }
}
