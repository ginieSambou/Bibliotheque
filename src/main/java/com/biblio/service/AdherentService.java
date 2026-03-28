package com.biblio.service;

import com.biblio.domain.Adherent;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.util.List;

public class AdherentService {
    private static final SessionFactory SESSION_FACTORY = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public List<Adherent> findAll() {
        try (Session session = SESSION_FACTORY.openSession()) {
            return session.createQuery("from Adherent", Adherent.class).list();
        }
    }

    public Adherent add(Adherent a) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.persist(a);
            tx.commit();
            return a;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public Adherent update(Adherent a) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.merge(a);
            tx.commit();
            return a;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public void delete(Adherent a) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Adherent attached = a;
            if (!session.contains(a)) {
                attached = session.merge(a);
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
