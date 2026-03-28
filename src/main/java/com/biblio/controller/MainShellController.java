package com.biblio.controller;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.scene.layout.StackPane;
import com.biblio.service.LivreService;
import com.biblio.service.AdherentService;
import com.biblio.service.EmpruntService;
import java.time.LocalDate;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.scene.control.Button;
import com.biblio.security.Session;
import javafx.scene.layout.VBox;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.SimpleObjectProperty;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import com.biblio.service.UtilisateurService;
import com.biblio.service.CategorieService;

public class MainShellController {
    @FXML
    private StackPane centerContainer;
    @FXML
    private VBox dashboardRoot;
    @FXML
    private VBox cardLivres;
    @FXML
    private VBox cardAdherents;
    @FXML
    private VBox cardRetards;
    @FXML
    private VBox cardMois;
    @FXML
    private Label lblDashLivres;
    @FXML
    private Label lblDashAdherents;
    @FXML
    private Label lblDashRetards;
    @FXML
    private Label lblDashMois;
    @FXML
    private Button btnUsers;
    @FXML
    private Button btnCategories;
    @FXML
    private Label lblUserName;
    @FXML
    private Label lblUserRole;
    @FXML
    private TableView<com.biblio.domain.Emprunt> tableRetards;
    @FXML
    private TableColumn<com.biblio.domain.Emprunt, String> colRLivre;
    @FXML
    private TableColumn<com.biblio.domain.Emprunt, String> colRAdherent;
    @FXML
    private TableColumn<com.biblio.domain.Emprunt, java.time.LocalDate> colRDateLimite;
    @FXML
    private TableColumn<com.biblio.domain.Emprunt, String> colRJours;
    @FXML
    private TableColumn<com.biblio.domain.Emprunt, String> colRPenalite;
    @FXML
    private javafx.scene.control.Label lblStatUsers;
    @FXML
    private javafx.scene.control.Label lblStatCategories;
    @FXML
    private javafx.scene.control.Label lblStatEmprunts;

    private final LivreService livreService = new LivreService();
    private final AdherentService adherentService = new AdherentService();
    private final EmpruntService empruntService = new EmpruntService();
    private final UtilisateurService utilisateurService = new UtilisateurService();
    private final CategorieService categorieService = new CategorieService();

    @FXML
    public void initialize() {
        if (!Session.isAuthenticated()) {
            onLogout();
            return;
        }
        if (lblUserName != null && Session.getCurrentUser() != null) {
            lblUserName.setText(Session.getCurrentUser().getNomUtilisateur());
        }
        if (lblUserRole != null && Session.getCurrentUser() != null) {
            lblUserRole.setText(Session.getCurrentUser().getRole());
        }
        if (btnUsers != null) {
            btnUsers.setVisible(Session.isAdmin());
            btnUsers.setManaged(Session.isAdmin());
        }
        if (btnCategories != null) {
            boolean admin = Session.isAdmin();
            btnCategories.setVisible(admin);
            btnCategories.setManaged(admin);
        }
        showDashboard();
    }

    @FXML
    private void showLivres() {
        try {
            Node node = FXMLLoader.load(getClass().getResource("/livres.fxml"));
            centerContainer.getChildren().setAll(node);
        } catch (Exception e) {
            centerContainer.getChildren().setAll(new Label("Erreur chargement Livres"));
        }
    }

    @FXML
    private void showAdherents() {
        try {
            Node node = FXMLLoader.load(getClass().getResource("/adherent-view.fxml"));
            centerContainer.getChildren().setAll(node);
        } catch (Exception e) {
            centerContainer.getChildren().setAll(new Label("Erreur chargement Adhérents"));
        }
    }

    @FXML
    private void showEmprunts() {
        try {
            Node node = FXMLLoader.load(getClass().getResource("/emprunt-view.fxml"));
            centerContainer.getChildren().setAll(node);
        } catch (Exception e) {
            centerContainer.getChildren().setAll(new Label("Erreur chargement Emprunts"));
        }
    }

    @FXML
    private void showCategories() {
        try {
            Node node = FXMLLoader.load(getClass().getResource("/categorie-view.fxml"));
            centerContainer.getChildren().setAll(node);
        } catch (Exception e) {
            centerContainer.getChildren().setAll(new Label("Erreur chargement Catégories"));
        }
    }

    @FXML
    private void showUsers() {
        try {
            Node node = FXMLLoader.load(getClass().getResource("/users-view.fxml"));
            centerContainer.getChildren().setAll(node);
        } catch (Exception e) {
            centerContainer.getChildren().setAll(new Label("Erreur chargement Utilisateurs"));
        }
    }

    @FXML
    private void showDashboard() {
        updateDashboardMetrics();
        centerContainer.getChildren().setAll(dashboardRoot);
    }

    private void updateDashboardMetrics() {
        if (lblDashLivres != null) {
            lblDashLivres.setText(String.valueOf(livreService.findAll().size()));
        }
        if (lblDashAdherents != null) {
            lblDashAdherents.setText(String.valueOf(adherentService.findAll().size()));
        }
        if (lblDashRetards != null) {
            long retards = empruntService.findAll().stream()
                    .filter(e -> e.getDateRetourEffective() == null
                            && e.getDateRetourPrevue() != null
                            && LocalDate.now().isAfter(e.getDateRetourPrevue()))
                    .count();
            lblDashRetards.setText(String.valueOf(retards));
        }
        if (lblDashMois != null) {
            YearMonth now = YearMonth.now();
            long count = empruntService.findAll().stream()
                    .filter(e -> e.getDateEmprunt() != null
                            && YearMonth.from(e.getDateEmprunt()).equals(now))
                    .count();
            lblDashMois.setText(String.valueOf(count));
        }
        long empruntsEnCours = empruntService.findAll().stream()
                .filter(e -> e.getDateRetourEffective() == null)
                .count();
        long usersActifs = utilisateurService.findAll().stream().filter(com.biblio.domain.Utilisateur::isActif).count();
        long categories = categorieService.findAll().size();
        if (lblStatEmprunts != null) lblStatEmprunts.setText(String.valueOf(empruntsEnCours));
        boolean admin = Session.isAdmin();
        if (lblStatUsers != null) {
            lblStatUsers.setText(admin ? String.valueOf(usersActifs) : "");
            lblStatUsers.setVisible(admin);
            lblStatUsers.setManaged(admin);
        }
        if (lblStatCategories != null) {
            lblStatCategories.setText(admin ? String.valueOf(categories) : "");
            lblStatCategories.setVisible(admin);
            lblStatCategories.setManaged(admin);
        }
        if (tableRetards != null) {
            var list = empruntService.findAll().stream()
                    .filter(e -> e.getDateRetourEffective() == null
                            && e.getDateRetourPrevue() != null
                            && LocalDate.now().isAfter(e.getDateRetourPrevue()))
                    .toList();
            tableRetards.getItems().setAll(list);
            if (colRLivre != null) {
                colRLivre.setCellValueFactory(cell -> {
                    var l = cell.getValue().getLivre();
                    return new SimpleStringProperty(l == null ? "" : l.getTitre());
                });
            }
            if (colRAdherent != null) {
                colRAdherent.setCellValueFactory(cell -> {
                    var a = cell.getValue().getAdherent();
                    if (a == null) return new SimpleStringProperty("");
                    String s = (a.getNom() == null ? "" : a.getNom()) + " " + (a.getPrenom() == null ? "" : a.getPrenom());
                    return new SimpleStringProperty(s.trim());
                });
            }
            if (colRDateLimite != null) {
                colRDateLimite.setCellValueFactory(cell -> new SimpleObjectProperty<>(cell.getValue().getDateRetourPrevue()));
            }
            if (colRJours != null) {
                colRJours.setCellValueFactory(cell -> {
                    var e = cell.getValue();
                    long days = ChronoUnit.DAYS.between(e.getDateRetourPrevue(), LocalDate.now());
                    return new SimpleStringProperty(String.valueOf(days));
                });
            }
            if (colRPenalite != null) {
                colRPenalite.setCellValueFactory(cell -> {
                    var e = cell.getValue();
                    long days = ChronoUnit.DAYS.between(e.getDateRetourPrevue(), LocalDate.now());
                    int penalite = (int) (days * 500);
                    return new SimpleStringProperty(String.valueOf(penalite));
                });
            }
        }
    }

    @FXML
    private void onLogout() {
        try {
            Session.clear();
            Node root = FXMLLoader.load(getClass().getResource("/login.fxml"));
            Stage stage = (Stage) centerContainer.getScene().getWindow();
            Scene scene = new Scene((javafx.scene.Parent) root);
            scene.getStylesheets().add(getClass().getResource("/styles.css").toExternalForm());
            stage.setTitle("Connexion");
            stage.setScene(scene);
            stage.show();
        } catch (Exception e) {
            // ignore
        }
    }
}
