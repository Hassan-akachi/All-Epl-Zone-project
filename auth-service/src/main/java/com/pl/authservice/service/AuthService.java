package com.pl.authservice.service;


import com.pl.authservice.dto.request.GoogleLoginRequestDto;
import com.pl.authservice.dto.request.LoginRequestDto;
import com.pl.authservice.dto.request.RegistrationRequestDTO;
import com.pl.authservice.dto.response.LoginResponseDto;
import com.pl.authservice.dto.response.RegistrationResponseDTO;
import com.pl.authservice.entity.Users;
import com.pl.authservice.repository.UsersRepository;
import com.pl.authservice.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final UsersRepository usersRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
   private final JwtService jwtService;

    public RegistrationResponseDTO register(RegistrationRequestDTO registrationRequestDTO) {
        usersRepository.findByEmail(registrationRequestDTO.email())
                .ifPresent( users -> {
            throw new RuntimeException("Email is already in use");
        });
        Users user = Users.builder()
                .username(registrationRequestDTO.username())
                .email(registrationRequestDTO.email())
                .password(passwordEncoder.encode(registrationRequestDTO.password()))
                .firstName(registrationRequestDTO.firstName())
                .lastName(registrationRequestDTO.lastName())
                .phoneNumber(registrationRequestDTO.phoneNumber())
                .build();

        usersRepository.save(user);

        return  RegistrationResponseDTO.builder().message("User registered successfully").build();
    }




    public LoginResponseDto login(LoginRequestDto loginRequestDto) {

        Users user = usersRepository.findByEmail(loginRequestDto.email())
                .orElseThrow(()-> new RuntimeException("User not found"));

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequestDto.email(), loginRequestDto.password())
        );

        String jwtToken = jwtService.generateToken(user);
        String expiryTime = String.valueOf(jwtService.getJwtExpiration());
        jwtService.saveToken(user, jwtToken);

        return LoginResponseDto.builder()
                .message("Login successful")
                .accessToken(jwtToken)
                .expiryTime(expiryTime)
                .build();
    }
//
    public LoginResponseDto login(GoogleLoginRequestDto googleLoginRequestDto) {
        return jwtService.verifyGoogleToken(googleLoginRequestDto.idToken());
    }

}
