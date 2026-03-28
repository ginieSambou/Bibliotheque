package com.biblio.controller;

import com.biblio.domain.Utilisateur;
import com.biblio.service.UtilisateurService;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class ChangePasswordController {
    @FXML
    private PasswordField txtNewPassword;
    @FXML
    private PasswordField txtConfirm;
    @FXML
    private Label lblError;

    private Utilisateur utilisateur;
    private final UtilisateurService utilisateurService = new UtilisateurService();
    private Runnable onSuccess;

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public void setOnSuccess(Runnable onSuccess) {
        this.onSuccess = onSuccess;
    }

    @FXML
    private void onValidate() {
        String p1 = txtNewPassword.getText();
        String p2 = txtConfirm.getText();
        if (p1 == null || p1.isBlank() || !p1.equals(p2)) {
            lblError.setText("Les mots de passe ne correspondent pas");
            return;
        }
        utilisateurService.setPassword(utilisateur, p1);
        if (onSuccess != null) onSuccess.run();
        Stage stage = (Stage) txtNewPassword.getScene().getWindow();
        stage.close();
    }
}
