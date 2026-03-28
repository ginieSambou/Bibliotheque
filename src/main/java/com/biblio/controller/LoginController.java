package com.biblio.controller;

import com.biblio.domain.Utilisateur;
import com.biblio.service.UtilisateurService;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import javafx.stage.Modality;
import com.biblio.security.Session;

public class LoginController {
    @FXML
    private TextField txtUsername;
    @FXML
    private PasswordField txtPassword;
    @FXML
    private Label lblError;

    private final UtilisateurService utilisateurService = new UtilisateurService();

    @FXML
    private void onLogin() {
        String username = txtUsername.getText();
        String password = txtPassword.getText();
        Utilisateur user = utilisateurService.authenticate(username, password);
        if (user != null) {
            Session.setCurrentUser(user);
            try {
                if (user.isMustChangePassword()) {
                    FXMLLoader loader = new FXMLLoader(getClass().getResource("/change-password.fxml"));
                    Parent dialog = loader.load();
                    ChangePasswordController ctrl = loader.getController();
                    ctrl.setUtilisateur(user);
                    ctrl.setOnSuccess(() -> {
                        try {
                            Parent root = FXMLLoader.load(getClass().getResource("/main-shell.fxml"));
                            Stage stage = (Stage) txtUsername.getScene().getWindow();
                            stage.setTitle("Gestion Bibliothèque");
                            Scene scene = new Scene(root);
                            scene.getStylesheets().add(getClass().getResource("/styles.css").toExternalForm());
                            stage.setScene(scene);
                            stage.show();
                        } catch (Exception ignored) {}
                    });
                    Stage stage = new Stage();
                    Scene scene = new Scene(dialog);
                    scene.getStylesheets().add(getClass().getResource("/styles.css").toExternalForm());
                    stage.setScene(scene);
                    stage.initModality(Modality.APPLICATION_MODAL);
                    stage.setTitle("Changement de mot de passe");
                    stage.showAndWait();
                } else {
                    Parent root = FXMLLoader.load(getClass().getResource("/main-shell.fxml"));
                    Stage stage = (Stage) txtUsername.getScene().getWindow();
                    stage.setTitle("Gestion Bibliothèque");
                    Scene scene = new Scene(root);
                    scene.getStylesheets().add(getClass().getResource("/styles.css").toExternalForm());
                    stage.setScene(scene);
                    stage.show();
                }
            } catch (Exception e) {
                lblError.setText("Erreur de chargement de l'application");
            }
        } else {
            lblError.setText("Identifiants invalides");
        }
    }
}
