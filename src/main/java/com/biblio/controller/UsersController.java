package com.biblio.controller;

import com.biblio.domain.Utilisateur;
import com.biblio.service.UtilisateurService;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import com.biblio.security.Session;

public class UsersController {
    @FXML
    private TableView<Utilisateur> tableUsers;
    @FXML
    private TableColumn<Utilisateur, String> colNom;
    @FXML
    private TableColumn<Utilisateur, String> colPrenom;
    @FXML
    private TableColumn<Utilisateur, String> colLogin;
    @FXML
    private TableColumn<Utilisateur, String> colEmail;
    @FXML
    private TableColumn<Utilisateur, String> colRole;
    @FXML
    private TableColumn<Utilisateur, Boolean> colActif;
    @FXML
    private TextField txtNom;
    @FXML
    private TextField txtPrenom;
    @FXML
    private TextField txtEmail;
    @FXML
    private TextField txtLogin;
    @FXML
    private PasswordField txtPassword;
    @FXML
    private ComboBox<String> cbRole;
    @FXML
    private CheckBox chkActif;

    private final UtilisateurService utilisateurService = new UtilisateurService();
    private final ObservableList<Utilisateur> data = FXCollections.observableArrayList();

    @FXML
    public void initialize() {
        colNom.setCellValueFactory(new PropertyValueFactory<>("nom"));
        colPrenom.setCellValueFactory(new PropertyValueFactory<>("prenom"));
        colLogin.setCellValueFactory(new PropertyValueFactory<>("nomUtilisateur"));
        if (colEmail != null) colEmail.setCellValueFactory(new PropertyValueFactory<>("email"));
        colRole.setCellValueFactory(new PropertyValueFactory<>("role"));
        colActif.setCellValueFactory(new PropertyValueFactory<>("actif"));
        data.setAll(utilisateurService.findAll());
        tableUsers.setItems(data);
        cbRole.setItems(FXCollections.observableArrayList("ADMIN", "BIBLIOTHECAIRE"));
        adjustColumnsVisibility();

        if (!Session.isAdmin()) {
            if (txtNom != null) txtNom.setDisable(true);
            if (txtPrenom != null) txtPrenom.setDisable(true);
            if (txtLogin != null) txtLogin.setDisable(true);
            if (txtPassword != null) txtPassword.setDisable(true);
            if (cbRole != null) cbRole.setDisable(true);
            if (chkActif != null) chkActif.setDisable(true);
        }
    }

    @FXML
    private void onAdd() {
        String nom = txtNom.getText();
        String prenom = txtPrenom.getText();
        String email = txtEmail.getText();
        String login = txtLogin.getText();
        String pwd = txtPassword.getText();
        String role = cbRole.getValue();
        boolean actif = chkActif.isSelected();
        if (isBlank(nom) || isBlank(prenom) || isBlank(email) || isBlank(login) || isBlank(pwd) || isBlank(role)) return;
        Utilisateur u = utilisateurService.addUser(nom.trim(), prenom.trim(), email.trim(), login.trim(), pwd, role, actif);
        data.add(u);
        clearForm();
        adjustColumnsVisibility();
    }

    @FXML
    private void onToggleActive() {
        Utilisateur u = tableUsers.getSelectionModel().getSelectedItem();
        if (u == null) return;
        u.setActif(!u.isActif());
        utilisateurService.updateUser(u);
        tableUsers.refresh();
    }

    @FXML
    private void onResetPassword() {
        Utilisateur u = tableUsers.getSelectionModel().getSelectedItem();
        if (u == null) return;
        TextInputDialog dialog = new TextInputDialog();
        dialog.setTitle("Réinitialiser le mot de passe");
        dialog.setHeaderText(null);
        dialog.setContentText("Nouveau mot de passe:");
        dialog.showAndWait().ifPresent(pwd -> {
            if (!isBlank(pwd)) {
                utilisateurService.setPassword(u, pwd);
            }
        });
    }

    private void clearForm() {
        txtNom.clear();
        txtPrenom.clear();
        if (txtEmail != null) txtEmail.clear();
        txtLogin.clear();
        txtPassword.clear();
        cbRole.setValue(null);
        chkActif.setSelected(true);
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
 
    private void adjustColumnsVisibility() {
        if (colEmail != null) {
            boolean anyEmail = data.stream().anyMatch(u -> u.getEmail() != null && !u.getEmail().isBlank());
            colEmail.setVisible(anyEmail);
        }
    }
}
