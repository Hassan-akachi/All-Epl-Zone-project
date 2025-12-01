package com.pl.authservice.dto.request;

public record LoginRequestDto(
        String email,
        String password
) {
}