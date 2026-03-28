package com.biblio.controller;

import com.biblio.domain.Categorie;
import com.biblio.service.CategorieService;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;

public class CategorieController {
    @FXML
    private TableView<Categorie> tableCategories;
    @FXML
    private TableColumn<Categorie, String> colLibelle;
    @FXML
    private TableColumn<Categorie, String> colDescription;
    @FXML
    private TextField txtLibelle;
    @FXML
    private TextField txtDescription;

    private final CategorieService categorieService = new CategorieService();
    private final ObservableList<Categorie> data = FXCollections.observableArrayList();

    @FXML
    public void initialize() {
        colLibelle.setCellValueFactory(new PropertyValueFactory<>("libelle"));
        if (colDescription != null) colDescription.setCellValueFactory(new PropertyValueFactory<>("description"));
        data.setAll(categorieService.findAll());
        tableCategories.setItems(data);
        adjustColumnsVisibility();
    }

    @FXML
    private void onAdd() {
        String libelle = txtLibelle.getText();
        String description = txtDescription != null ? txtDescription.getText() : null;
        if (libelle == null || libelle.isBlank()) return;
        Categorie c = new Categorie();
        c.setLibelle(libelle.trim());
        if (description != null && !description.isBlank()) c.setDescription(description.trim());
        categorieService.add(c);
        data.add(c);
        txtLibelle.clear();
        if (txtDescription != null) txtDescription.clear();
        adjustColumnsVisibility();
    }

    @FXML
    private void onDelete() {
        Categorie selected = tableCategories.getSelectionModel().getSelectedItem();
        if (selected == null) return;
        categorieService.delete(selected);
        data.remove(selected);
        adjustColumnsVisibility();
    }
 
    private void adjustColumnsVisibility() {
        if (colDescription != null) {
            boolean anyDesc = data.stream().anyMatch(c -> c.getDescription() != null && !c.getDescription().isBlank());
            colDescription.setVisible(anyDesc);
        }
    }
}
