package com.biblio.service;

import com.biblio.domain.Livre;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class LivreService {
    private static final SessionFactory SESSION_FACTORY = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public List<Livre> findAll() {
        try (Session session = SESSION_FACTORY.openSession()) {
            return session.createQuery("from Livre", Livre.class).list();
        }
    }

    public Optional<Livre> findByIsbn(String isbn) {
        try (Session session = SESSION_FACTORY.openSession()) {
            Query<Livre> query = session.createQuery("from Livre l where l.isbn = :isbn", Livre.class);
            query.setParameter("isbn", isbn);
            return query.uniqueResultOptional();
        }
    }

    public Livre add(Livre l) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.persist(l);
            tx.commit();
            return l;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public Livre update(Livre l) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            session.merge(l);
            tx.commit();
            return l;
        } catch (RuntimeException e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public void delete(Livre l) {
        Transaction tx = null;
        try (Session session = SESSION_FACTORY.openSession()) {
            tx = session.beginTransaction();
            Livre attached = l;
            if (!session.contains(l)) {
                attached = session.merge(l);
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
