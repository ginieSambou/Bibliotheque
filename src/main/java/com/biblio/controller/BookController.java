package com.biblio.controller;

import com.biblio.domain.Livre;
import com.biblio.domain.Categorie;
import com.biblio.service.LivreService;
import com.biblio.service.CategorieService;
import com.biblio.util.EventBus;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.util.converter.IntegerStringConverter;
import javafx.util.StringConverter;
import com.biblio.security.Session;

public class BookController {
    @FXML private TableView<Livre> tableLivres;
    @FXML private TableColumn<Livre, String> colTitre;
    @FXML private TableColumn<Livre, String> colAuteur;
    @FXML private TableColumn<Livre, String> colIsbn;
    @FXML private TableColumn<Livre, Integer> colAnnee;
    @FXML private TableColumn<Livre, String> colCategorie;
    @FXML private TableColumn<Livre, Integer> colStockTotal;
    @FXML private TableColumn<Livre, Boolean> colDisponible;
    @FXML private TextField txtTitre;
    @FXML private TextField txtAuteur;
    @FXML private TextField txtIsbn;
    @FXML private TextField txtAnnee;
    @FXML private ComboBox<Categorie> comboCategorie;
    @FXML private ComboBox<Categorie> filterCategorie;
    @FXML private TextField txtSearchTitre;
    @FXML private Button btnAdd;
    @FXML private Button btnDelete;

    private final LivreService livreService = new LivreService();
    private final CategorieService categorieService = new CategorieService();
    private final ObservableList<Livre> data = FXCollections.observableArrayList();
    private FilteredList<Livre> filtered;

    @FXML
    public void initialize() {
        tableLivres.setEditable(Session.isAdmin());
        colTitre.setCellValueFactory(new PropertyValueFactory<>("titre"));
        colAuteur.setCellValueFactory(new PropertyValueFactory<>("auteur"));
        colIsbn.setCellValueFactory(new PropertyValueFactory<>("isbn"));
        colAnnee.setCellValueFactory(new PropertyValueFactory<>("anneePublication"));

        data.setAll(livreService.findAll());
        filtered = new FilteredList<>(data, this::matchesFilters);
        tableLivres.setItems(filtered);

        if (comboCategorie != null) {
            comboCategorie.setConverter(new StringConverter<>() {
                @Override
                public String toString(Categorie c) {
                    return c == null ? "" : c.getLibelle();
                }
                @Override
                public Categorie fromString(String string) { return null; }
            });
            comboCategorie.setItems(FXCollections.observableArrayList(categorieService.findAll()));
        }

        if (colCategorie != null) {
            colCategorie.setCellValueFactory(cell -> {
                Categorie c = cell.getValue().getCategorie();
                return new SimpleStringProperty(c == null ? "" : c.getLibelle());
            });
        }

        if (colStockTotal != null && Session.isAdmin()) {
            colStockTotal.setCellValueFactory(new PropertyValueFactory<>("nombreExemplaires"));
            colStockTotal.setCellFactory(TextFieldTableCell.forTableColumn(new IntegerStringConverter()));
            colStockTotal.setOnEditCommit(ev -> {
                Livre l = ev.getRowValue();
                Integer newVal = ev.getNewValue();
                if (newVal == null || newVal < 0) return;
                l.setNombreExemplaires(newVal);
                if (l.getExemplairesDisponibles() > newVal) {
                    l.setExemplairesDisponibles(newVal);
                }
                l.setDisponible(l.getExemplairesDisponibles() > 0);
                livreService.update(l);
                tableLivres.refresh();
            });
        }

        if (colDisponible != null) {
            colDisponible.setCellValueFactory(new PropertyValueFactory<>("disponible"));
            colDisponible.setCellFactory(col -> new TableCell<>() {
                @Override
                protected void updateItem(Boolean item, boolean empty) {
                    super.updateItem(item, empty);
                    if (empty) {
                        setGraphic(null);
                        setText(null);
                        setStyle("");
                    } else {
                        boolean ok = item != null && item;
                        String text = ok ? "Disponible" : "Indisponible";
                        String color = ok ? "#27ae60" : "#e74c3c";
                        Label pill = new Label(text); // ✅ Import ajouté
                        pill.setStyle("-fx-background-color: " + color + "; -fx-text-fill: white; -fx-padding: 3 10; -fx-background-radius: 12;");
                        setGraphic(pill);
                        setText(null);
                    }
                }
            });
            colDisponible.setEditable(false);
        }

        if (filterCategorie != null) {
            filterCategorie.setConverter(new StringConverter<>() {
                @Override
                public String toString(Categorie c) {
                    return c == null ? "" : c.getLibelle();
                }
                @Override
                public Categorie fromString(String string) { return null; }
            });
            filterCategorie.setItems(FXCollections.observableArrayList(categorieService.findAll()));
            filterCategorie.valueProperty().addListener((obs, oldV, newV) -> refreshFilter());
        }

        if (txtSearchTitre != null) {
            txtSearchTitre.textProperty().addListener((obs, ov, nv) -> refreshFilter());
        }

        if (!Session.isAdmin()) {
            if (txtTitre != null) txtTitre.setDisable(true);
            if (txtAuteur != null) txtAuteur.setDisable(true);
            if (txtIsbn != null) txtIsbn.setDisable(true);
            if (txtAnnee != null) txtAnnee.setDisable(true);
            if (comboCategorie != null) comboCategorie.setDisable(true);
            if (btnAdd != null) { btnAdd.setVisible(false); btnAdd.setManaged(false); }
            if (btnDelete != null) { btnDelete.setVisible(false); btnDelete.setManaged(false); }
        }

        EventBus.addListener("STOCK_UPDATED", evt -> {
            data.setAll(livreService.findAll());
            tableLivres.refresh();
        });
    }

    @FXML
    private void onAdd() {
        if (!Session.isAdmin()) return;
        String titre = txtTitre.getText();
        String auteur = txtAuteur.getText();
        String isbn = txtIsbn.getText();
        String anneeTxt = txtAnnee.getText();
        Categorie categorie = comboCategorie != null ? comboCategorie.getValue() : null;
        Integer annee = null;

        if (anneeTxt != null && !anneeTxt.isBlank()) {
            try {
                annee = Integer.parseInt(anneeTxt.trim());
            } catch (NumberFormatException ignored) { return; }
        }

        if (titre == null || titre.isBlank() || auteur == null || auteur.isBlank() || isbn == null || isbn.isBlank()) {
            return;
        }

        Livre l = new Livre();
        l.setTitre(titre.trim());
        l.setAuteur(auteur.trim());
        l.setIsbn(isbn.trim());
        l.setAnneePublication(annee);
        l.setCategorie(categorie);
        l.setNombreExemplaires(1);
        l.setExemplairesDisponibles(1);
        l.setDisponible(true);

        livreService.add(l);
        data.add(l);

        txtTitre.clear();
        txtAuteur.clear();
        txtIsbn.clear();
        txtAnnee.clear();
        if (comboCategorie != null) comboCategorie.setValue(null);

        refreshFilter();
    }

    @FXML
    private void onDelete() {
        if (!Session.isAdmin()) return;
        Livre selected = tableLivres.getSelectionModel().getSelectedItem();
        if (selected == null) return;

        Alert confirm = new Alert(Alert.AlertType.CONFIRMATION, "Supprimer ce livre ?", ButtonType.OK, ButtonType.CANCEL);
        confirm.setHeaderText(null);
        var res = confirm.showAndWait();
        if (res.isEmpty() || res.get() != ButtonType.OK) return;

        livreService.delete(selected);
        data.remove(selected);
        refreshFilter();
    }

    @FXML
    private void onResetFilter() {
        if (filterCategorie != null) filterCategorie.setValue(null);
        if (txtSearchTitre != null) txtSearchTitre.clear();
        refreshFilter();
    }

    private boolean matchesFilters(Livre l) {
        if (l == null) return false;
        Categorie cat = filterCategorie != null ? filterCategorie.getValue() : null;
        String query = txtSearchTitre != null ? txtSearchTitre.getText() : null;

        boolean catOk = (cat == null) || (l.getCategorie() != null && cat.getId() != null && cat.getId().equals(l.getCategorie().getId()));
        String q = (query == null) ? "" : query.trim().toLowerCase();

        boolean textOk;
        if (q.isBlank()) {
            textOk = true;
        } else {
            boolean inTitre = l.getTitre() != null && l.getTitre().toLowerCase().contains(q);
            boolean inAuteur = l.getAuteur() != null && l.getAuteur().toLowerCase().contains(q);
            boolean inIsbn = l.getIsbn() != null && l.getIsbn().toLowerCase().contains(q);
            textOk = inTitre || inAuteur || inIsbn;
        }
        return catOk && textOk;
    }

    private void refreshFilter() {
        if (filtered != null) {
            filtered.setPredicate(this::matchesFilters);
        }
    }
}
