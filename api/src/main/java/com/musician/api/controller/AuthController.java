package com.musician.api.controller;

import com.musician.api.exception.UnauthorizedException;
import com.musician.api.model.User;
import com.musician.api.model.UserProfile;
import com.musician.api.repository.UserProfileRepository;
import com.musician.api.repository.UserRepository;
import com.musician.api.request.LoginRequest;
import com.musician.api.request.RegisterRequest;
import com.musician.api.response.LoginResponse;
import com.musician.api.response.UserResponse;
import com.musician.api.service.JwtUtil;
import jakarta.validation.Valid;
import java.util.Optional;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

  private final UserRepository userRepository;
  private final UserProfileRepository userProfileRepository;
  private final PasswordEncoder passwordEncoder;
  private final AuthenticationManager authenticationManager;
  private final JwtUtil jwtUtil;

  public AuthController(
      UserRepository userRepository,
      UserProfileRepository userProfileRepository,
      PasswordEncoder passwordEncoder,
      AuthenticationManager authenticationManager,
      JwtUtil jwtUtil) {
    this.userRepository = userRepository;
    this.userProfileRepository = userProfileRepository;
    this.passwordEncoder = passwordEncoder;
    this.authenticationManager = authenticationManager;
    this.jwtUtil = jwtUtil;
  }

  @PostMapping("/register")
  public UserResponse register(@Valid @RequestBody RegisterRequest registerRequest) {
    User user =
        User.builder()
            .firstName(registerRequest.getFirstName())
            .lastName(registerRequest.getLastName())
            .password(passwordEncoder.encode(registerRequest.getPassword()))
            .emailAddress(registerRequest.getEmailAddress())
            .build();

    user.setIsOnline(false);
    userRepository.save(user);

    if (registerRequest.getProfileName() != null) {
      UserProfile profile =
          UserProfile.builder().profileName(registerRequest.getProfileName()).user(user).build();

      if (registerRequest.getDescription() != null) {
        profile.setDescription(registerRequest.getDescription());
      }

      if (registerRequest.getMusicalInfluences() != null) {
        profile.setMusicalInfluences(registerRequest.getMusicalInfluences());
      }

      if (registerRequest.getPlayedInstruments() != null) {
        profile.setPlayedInstruments(registerRequest.getPlayedInstruments());
      }

      userProfileRepository.save(profile);
    }

    return new UserResponse(user);
  }

  @PostMapping("/login")
  public LoginResponse login(@Valid @RequestBody LoginRequest loginRequest) {
    Optional<User> optionalUser = userRepository.findByEmailAddress(loginRequest.getEmailAddress());

    if (optionalUser.isEmpty()) {
      throw new UnauthorizedException("No account associated with this email.");
    }

    User user = optionalUser.get();

    authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(user.getUsername(), loginRequest.getPassword()));

    user.setIsOnline(true);
    userRepository.save(user);

    return LoginResponse.builder()
        .jwt(jwtUtil.generateToken(user.getUsername()))
        .userId(user.getId())
        .build();
  }

  @PostMapping("/logout")
  public ResponseEntity<?> logout(Authentication authentication) {
    if (authentication != null && authentication.getName() != null) {
      Optional<User> optionalUser = userRepository.findByUsername(authentication.getName());
      if (optionalUser.isPresent()) {
        User user = optionalUser.get();
        user.setIsOnline(false);
        userRepository.save(user);
      }
    }

    return ResponseEntity.ok().build();
  }

  @GetMapping("/me")
  public UserResponse me() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    if (authentication == null || !authentication.isAuthenticated()) {
      throw new UnauthorizedException("You must be authenticated to access this resource.");
    }

    String username = authentication.getName();

    User user =
        userRepository
            .findByUsername(username)
            .orElseThrow(() -> new UnauthorizedException("User not found"));

    return new UserResponse(user);
  }
}
