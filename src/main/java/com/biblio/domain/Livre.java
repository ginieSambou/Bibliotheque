package com.biblio.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "livres")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String titre;

    @Column(nullable = false, length = 255)
    private String auteur;

    @Column(nullable = false, unique = true, length = 20)
    private String isbn;

    @Column(name = "annee_publication")
    private Integer anneePublication;

    @ManyToOne
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;

    @OneToMany(mappedBy = "livre")
    private Set<Emprunt> emprunts = new HashSet<>();

    @Column(name = "exemplaires_disponibles", nullable = false)
    private int exemplairesDisponibles;

    @Column(name = "nombre_exemplaires", nullable = false)
    private int nombreExemplaires;

    @Column(name = "disponible", nullable = false)
    private boolean disponible = false;

    public Livre() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Integer getAnneePublication() {
        return anneePublication;
    }

    public void setAnneePublication(Integer anneePublication) {
        this.anneePublication = anneePublication;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    public Set<Emprunt> getEmprunts() {
        return emprunts;
    }

    public void setEmprunts(Set<Emprunt> emprunts) {
        this.emprunts = emprunts;
    }

    public int getExemplairesDisponibles() {
        return exemplairesDisponibles;
    }

    public void setExemplairesDisponibles(int exemplairesDisponibles) {
        this.exemplairesDisponibles = exemplairesDisponibles;
    }

    public int getNombreExemplaires() {
        return nombreExemplaires;
    }

    public void setNombreExemplaires(int nombreExemplaires) {
        this.nombreExemplaires = nombreExemplaires;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
}
