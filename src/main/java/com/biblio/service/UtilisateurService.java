package com.biblio.service;

import com.biblio.domain.Utilisateur;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.mindrot.jbcrypt.BCrypt;
import java.time.LocalDateTime;

public class UtilisateurService {
    private static final SessionFactory SESSION_FACTORY = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public boolean verifyCredentials(String username, String password) {
        return authenticate(username, password) != null;
    }

    public Utilisateur authenticate(String username, String password) {
        if (username == null || password == null) return null;
        try (Session session = SESSION_FACTORY.openSession()) {
            Utilisateur u = session.createQuery("from Utilisateur where nomUtilisateur = :u and actif = true", Utilisateur.class)
                    .setParameter("u", username)
                    .uniqueResult();
            if (u == null) return null;
            boolean ok = BCrypt.checkpw(password, u.getMotDePasseHache());
            if (!ok) return null;
            Transaction tx = session.beginTransaction();
            u.setDerniereConnexion(java.time.LocalDateTime.now());
            session.merge(u);
            tx.commit();
            return u;
        }
    }

    public void ensureDefaultAdmin() {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Utilisateur u = session.createQuery("from Utilisateur where nomUtilisateur = :u", Utilisateur.class)
                    .setParameter("u", "admin")
                    .uniqueResult();
            if (u == null) {
                Utilisateur admin = new Utilisateur();
                admin.setNomUtilisateur("admin");
                admin.setMotDePasseHache(BCrypt.hashpw("admin123", BCrypt.gensalt()));
                admin.setRole("ADMIN");
                admin.setActif(true);
                admin.setMustChangePassword(true);
                admin.setEmail("admin@biblio.local");
                admin.setDateCreation(LocalDateTime.now());
                session.persist(admin);
            }
            tx.commit();
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public java.util.List<Utilisateur> findAll() {
        try (Session session = SESSION_FACTORY.openSession()) {
            return session.createQuery("from Utilisateur", Utilisateur.class).list();
        }
    }

    public Utilisateur addUser(String nom, String prenom, String email, String nomUtilisateur, String password, String role, boolean actif) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Utilisateur u = new Utilisateur();
            u.setNom(nom);
            u.setPrenom(prenom);
            u.setEmail(email);
            u.setNomUtilisateur(nomUtilisateur);
            u.setMotDePasseHache(BCrypt.hashpw(password, BCrypt.gensalt()));
            u.setRole(role);
            u.setActif(actif);
            u.setMustChangePassword(true);
            u.setDateCreation(LocalDateTime.now());
            session.persist(u);
            tx.commit();
            return u;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public Utilisateur updateUser(Utilisateur u) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.merge(u);
            tx.commit();
            return u;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public void setPassword(Utilisateur u, String newPassword) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Utilisateur managed = session.get(Utilisateur.class, u.getId());
            managed.setMotDePasseHache(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
            managed.setMustChangePassword(false);
            session.merge(managed);
            tx.commit();
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }
}
