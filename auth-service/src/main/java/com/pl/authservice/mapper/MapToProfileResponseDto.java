package com.pl.authservice.mapper;

import com.pl.authservice.dto.response.ProfileResponseDto;
import com.pl.authservice.entity.Users;
import org.springframework.stereotype.Component;

@Component
public class MapToProfileResponseDto {

    public ProfileResponseDto toProfileResponseDto(Users users){
        return ProfileResponseDto.builder()
                .firstName(users.getFirstName())
                .lastName(users.getLastName())
                .email(users.getEmail())
                .phoneNumber(String.valueOf(users.getPhoneNumber()))
                .build();
    }
}
