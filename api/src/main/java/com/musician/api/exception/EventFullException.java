package com.musician.api.exception;

public class EventFullException extends RuntimeException {
    public EventFullException(Long eventId) {
        super("Event with ID " + eventId + " is full.");
    }
}