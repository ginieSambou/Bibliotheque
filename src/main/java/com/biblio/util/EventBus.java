package com.biblio.util;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

public class EventBus {
    private static final List<Consumer<String>> listeners = new ArrayList<>();

    public static void addListener(String event, Consumer<String> listener) {
        listeners.add(l -> {
            if (event.equals(l)) {
                listener.accept(l);
            }
        });
    }

    public static void post(String event) {
        for (Consumer<String> c : listeners) {
            try {
                c.accept(event);
            } catch (Exception ignored) {}
        }
    }
}
