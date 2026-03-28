package com.biblio.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100)
    private String nom;

    @Column(length = 100)
    private String prenom;

    @Column(name = "nom_utilisateur", nullable = false, unique = true, length = 100)
    private String nomUtilisateur;

    @Column(name = "mot_de_passe_hache", nullable = false, length = 255)
    private String motDePasseHache;

    @Column(nullable = false, length = 50)
    private String role;

    @Column(nullable = false)
    private boolean actif = true;

    @Column(name = "must_change_password", nullable = false)
    private boolean mustChangePassword = false;
 
    @Column(length = 150, unique = true)
    private String email;
 
    @Column(name = "date_creation")
    private LocalDateTime dateCreation;
 
    @Column(name = "derniere_connexion")
    private LocalDateTime derniereConnexion;
    public Utilisateur() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNomUtilisateur() {
        return nomUtilisateur;
    }

    public void setNomUtilisateur(String nomUtilisateur) {
        this.nomUtilisateur = nomUtilisateur;
    }

    public String getMotDePasseHache() {
        return motDePasseHache;
    }

    public void setMotDePasseHache(String motDePasseHache) {
        this.motDePasseHache = motDePasseHache;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public boolean isMustChangePassword() {
        return mustChangePassword;
    }

    public void setMustChangePassword(boolean mustChangePassword) {
        this.mustChangePassword = mustChangePassword;
    }
 
    public String getEmail() {
        return email;
    }
 
    public void setEmail(String email) {
        this.email = email;
    }
 
    public LocalDateTime getDateCreation() {
        return dateCreation;
    }
 
    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }
 
    public LocalDateTime getDerniereConnexion() {
        return derniereConnexion;
    }
 
    public void setDerniereConnexion(LocalDateTime derniereConnexion) {
        this.derniereConnexion = derniereConnexion;
    }
}
