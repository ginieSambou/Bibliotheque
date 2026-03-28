package com.biblio.controller;

import com.biblio.service.AdherentService;
import com.biblio.service.EmpruntService;
import com.biblio.service.LivreService;
import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.time.LocalDate;

public class DashboardController {
    @FXML
    private Label lblTotalLivres;
    @FXML
    private Label lblTotalAdherents;
    @FXML
    private Label lblRetards;

    private final LivreService livreService = new LivreService();
    private final AdherentService adherentService = new AdherentService();
    private final EmpruntService empruntService = new EmpruntService();

    @FXML
    public void initialize() {
        lblTotalLivres.setText(String.valueOf(livreService.findAll().size()));
        lblTotalAdherents.setText(String.valueOf(adherentService.findAll().size()));
        long retards = empruntService.findAll().stream()
                .filter(e -> e.getDateRetourEffective() == null
                        && e.getDateRetourPrevue() != null
                        && LocalDate.now().isAfter(e.getDateRetourPrevue()))
                .count();
        lblRetards.setText(String.valueOf(retards));
    }
}
