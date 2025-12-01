package com.pl.authservice.dto.request;

public record RegistrationRequestDTO (
        String username,
        String email,
        String password,
        String firstName,
        String lastName,
        String phoneNumber
) {

        }
