package com.biblio;

import com.biblio.service.UtilisateurService;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MainApp extends Application {
    @Override
    public void start(Stage stage) throws Exception {
        // Crée un admin par défaut si nécessaire
        new UtilisateurService().ensureDefaultAdmin();

        // Charge la vue de connexion
        Parent root = FXMLLoader.load(getClass().getResource("/login.fxml"));
        Scene scene = new Scene(root);

        // Ajout du CSS
        scene.getStylesheets().add(getClass().getResource("/styles.css").toExternalForm());

        stage.setTitle("Connexion");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}