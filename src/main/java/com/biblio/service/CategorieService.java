package com.biblio.service;

import com.biblio.domain.Categorie;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.util.List;

public class CategorieService {
    private static final SessionFactory SESSION_FACTORY = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public List<Categorie> findAll() {
        try (Session session = SESSION_FACTORY.openSession()) {
            return session.createQuery("from Categorie", Categorie.class).list();
        }
    }

    public Categorie add(Categorie c) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.persist(c);
            tx.commit();
            return c;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public Categorie update(Categorie c) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.merge(c);
            tx.commit();
            return c;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public void delete(Categorie c) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Categorie attached = c;
            if (!session.contains(c)) {
                attached = session.merge(c);
            }
            session.remove(attached);
            tx.commit();
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public static void shutdown() {
        SESSION_FACTORY.close();
    }
}
