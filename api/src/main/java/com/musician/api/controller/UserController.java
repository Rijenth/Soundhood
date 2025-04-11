package com.musician.api.controller;

import com.musician.api.model.User;
import com.musician.api.repository.UserRepository;
import com.musician.api.response.UserResponse;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserController {
  private final UserRepository userRepository;

  public UserController(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @GetMapping
  public ResponseEntity<List<UserResponse>> getAllUsersExceptCurrent(
      @AuthenticationPrincipal UserDetails userDetails) {
    String currentUsername = userDetails.getUsername();
    List<User> users = userRepository.findByUsernameNot(currentUsername);
    List<UserResponse> userResponses =
        users.stream().map(UserResponse::new).collect(Collectors.toList());
    return ResponseEntity.ok(userResponses);
  }

  @GetMapping("/{userId}")
  public ResponseEntity<UserResponse> getUserById(@PathVariable Long userId) {
    User user =
        userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
    return ResponseEntity.ok(new UserResponse(user));
  }
}
