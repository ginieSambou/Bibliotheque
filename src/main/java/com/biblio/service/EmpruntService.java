package com.biblio.service;

import com.biblio.domain.Emprunt;
import com.biblio.domain.Livre;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.time.LocalDate;
import java.util.List;

public class EmpruntService {
    private static final SessionFactory SESSION_FACTORY = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public List<Emprunt> findAll() {
        try (Session session = SESSION_FACTORY.openSession()) {
            return session.createQuery("from Emprunt", Emprunt.class).list();
        }
    }
 
    public List<Emprunt> findByAdherentId(Long adherentId) {
        if (adherentId == null) return java.util.Collections.emptyList();
        try (Session session = SESSION_FACTORY.openSession()) {
            return session.createQuery("from Emprunt e where e.adherent.id = :id order by e.dateEmprunt desc", Emprunt.class)
                    .setParameter("id", adherentId)
                    .list();
        }
    }

    public Emprunt add(Emprunt e) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Livre managedLivre = session.get(Livre.class, e.getLivre().getId());
            if (managedLivre == null) {
                throw new RuntimeException("Livre introuvable");
            }
            if (managedLivre.getExemplairesDisponibles() <= 0) {
                throw new RuntimeException("Stock épuisé pour ce livre");
            }
            managedLivre.setExemplairesDisponibles(managedLivre.getExemplairesDisponibles() - 1);
            managedLivre.setDisponible(managedLivre.getExemplairesDisponibles() > 0);
            session.merge(managedLivre);
            e.setLivre(managedLivre);
            session.persist(e);
            tx.commit();
            return e;
        } catch (RuntimeException ex) {
            if (tx != null) tx.rollback();
            throw ex;
        }
    }

    public void delete(Emprunt e) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Emprunt attached = e;
            if (!session.contains(e)) {
                attached = session.merge(e);
            }
            session.remove(attached);
            tx.commit();
        } catch (RuntimeException ex) {
            if (tx != null) tx.rollback();
            throw ex;
        }
    }

    public Emprunt enregistrerRetour(Emprunt e) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Emprunt attached = e;
            if (!session.contains(e)) {
                attached = session.merge(e);
            }
            attached.setDateRetourEffective(LocalDate.now());
            if (attached.getDateRetourPrevue() != null && attached.getDateRetourEffective() != null) {
                if (attached.getDateRetourEffective().isAfter(attached.getDateRetourPrevue())) {
                    long days = java.time.temporal.ChronoUnit.DAYS.between(attached.getDateRetourPrevue(), attached.getDateRetourEffective());
                    int penalite = (int) (days * 500);
                    attached.setMontantPenalite(penalite);
                } else {
                    attached.setMontantPenalite(0);
                }
            }
            Livre managedLivre = session.get(Livre.class, attached.getLivre().getId());
            if (managedLivre != null) {
                managedLivre.setExemplairesDisponibles(managedLivre.getExemplairesDisponibles() + 1);
                managedLivre.setDisponible(managedLivre.getExemplairesDisponibles() > 0);
                session.merge(managedLivre);
            }
            tx.commit();
            return attached;
        } catch (RuntimeException ex) {
            if (tx != null) tx.rollback();
            throw ex;
        }
    }

    public static void shutdown() {
        SESSION_FACTORY.close();
    }
}
