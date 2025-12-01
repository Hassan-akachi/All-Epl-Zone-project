package com.pl.authservice.controller;
import com.pl.authservice.dto.response.ProfileResponseDto;
import com.pl.authservice.service.ProfileService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/profile")
public class ProfileController {
    private final ProfileService profileService;
    @GetMapping
    public ResponseEntity<ProfileResponseDto> profile(){

        return  ResponseEntity.status(HttpStatus.OK).body(profileService.viewUser());
    }
}