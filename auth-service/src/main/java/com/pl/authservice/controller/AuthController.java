package com.pl.authservice.controller;

import com.pl.authservice.dto.request.GoogleLoginRequestDto;
import com.pl.authservice.dto.request.LoginRequestDto;
import com.pl.authservice.dto.request.RegistrationRequestDTO;
import com.pl.authservice.dto.response.LoginResponseDto;
import com.pl.authservice.dto.response.RegistrationResponseDTO;
import com.pl.authservice.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/authentication")
public class AuthController {

private  final AuthService authService ;

    @PostMapping("/register")
    public ResponseEntity<RegistrationResponseDTO> register(@RequestBody RegistrationRequestDTO request) {
        // Registration logic here
 RegistrationResponseDTO responseDTO = authService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseDTO);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDto> login(@RequestBody LoginRequestDto loginRequestDto){
        LoginResponseDto loginResponse = authService.login(loginRequestDto);
        return  ResponseEntity.status(HttpStatus.OK).body(loginResponse);
    }

    @PostMapping("/google-login")
    public ResponseEntity<LoginResponseDto> googleLogin(@RequestBody GoogleLoginRequestDto googleLoginRequestDto){
        LoginResponseDto loginResponse = authService.login(googleLoginRequestDto);
        return  ResponseEntity.status(HttpStatus.OK).body(loginResponse);
    }

}
