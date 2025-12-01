package com.pl.authservice.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ProfileResponseDto {
    private  String email;
    private  String firstName;
    private  String lastName;
    private  String phoneNumber;
    private  String username;
}