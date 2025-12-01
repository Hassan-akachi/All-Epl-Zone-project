package com.pl.authservice.service;
import com.pl.authservice.dto.response.ProfileResponseDto;
import com.pl.authservice.entity.Users;
import com.pl.authservice.mapper.MapToProfileResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ProfileService {

    private final MapToProfileResponseDto mapToProfileResponseDto;
    public ProfileResponseDto viewUser(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        Users principal = (Users) authentication.getPrincipal();

        return mapToProfileResponseDto.toProfileResponseDto(principal);
    }

}