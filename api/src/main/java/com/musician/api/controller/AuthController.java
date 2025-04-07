package com.musician.api.controller;

import com.musician.api.model.User;
import com.musician.api.repository.UserRepository;
import com.musician.api.request.AuthenticationRequest;
import com.musician.api.response.UserResponse;
import com.musician.api.service.JwtUtil;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;
    private final JwtUtil jwtUtil;

    public AuthController(
            UserRepository userRepository,
            PasswordEncoder passwordEncoder,
            AuthenticationManager authenticationManager,
            UserDetailsService userDetailsService,
            JwtUtil jwtUtil
    ) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.userDetailsService = userDetailsService;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/register")
    public UserResponse register(@Valid @RequestBody AuthenticationRequest authenticationRequest) {
        User user = User.builder()
                .firstName(authenticationRequest.getFirstName())
                .lastName(authenticationRequest.getLastName())
                .password(passwordEncoder.encode(authenticationRequest.getPassword()))
                .build();

        userRepository.save(user);

        return new UserResponse(user);
    }
}
