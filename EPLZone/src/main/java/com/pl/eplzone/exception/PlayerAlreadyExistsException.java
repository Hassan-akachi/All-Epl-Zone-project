package com.pl.eplzone.exception;

// PlayerNotFoundException.java (in same file for brevity)
public class PlayerAlreadyExistsException extends RuntimeException {
    public PlayerAlreadyExistsException(String message) {
        super(message);
    }
}