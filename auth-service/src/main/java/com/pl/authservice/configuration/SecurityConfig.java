

package com.pl.authservice.configuration;

import com.pl.authservice.exceptions.AccessDeniedExceptionHandler;
import com.pl.authservice.exceptions.AuthenticationExceptionHandler;
import com.pl.authservice.security.JWTFilterConfig;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private final AuthenticationProvider authenticationProvider;
    private final JWTFilterConfig jwtFilterConfig;
    private final AuthenticationExceptionHandler authenticationExceptionHandler;
    private final AccessDeniedExceptionHandler accessDeniedExceptionHandler;

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        return http
                .csrf(AbstractHttpConfigurer::disable)
                .cors(AbstractHttpConfigurer::disable)

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(HttpMethod.POST,
                                "/authentication/register",
                                "/authentication/login",
                                "/authentication/google-login"
                        ).permitAll()
                        .anyRequest().authenticated()
                )

                .exceptionHandling(ex -> {
                    ex.authenticationEntryPoint(authenticationExceptionHandler);
                    ex.accessDeniedHandler(accessDeniedExceptionHandler);
                })

                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                .authenticationProvider(authenticationProvider)
                .addFilterBefore(jwtFilterConfig, UsernamePasswordAuthenticationFilter.class)

                .build();
    }
}
