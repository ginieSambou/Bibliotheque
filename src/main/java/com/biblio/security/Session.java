package com.biblio.security;

import com.biblio.domain.Utilisateur;

public class Session {
    private static Utilisateur currentUser;

    public static void setCurrentUser(Utilisateur user) {
        currentUser = user;
    }

    public static Utilisateur getCurrentUser() {
        return currentUser;
    }

    public static boolean isAdmin() {
        return currentUser != null && "ADMIN".equalsIgnoreCase(currentUser.getRole());
    }
 
    public static boolean isAuthenticated() {
        return currentUser != null;
    }
 
    public static void clear() {
        currentUser = null;
    }
}
