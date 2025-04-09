package com.musician.api.controller;

import com.musician.api.exception.UnauthorizedException;
import com.musician.api.model.User;
import com.musician.api.model.UserProfile;
import com.musician.api.repository.UserProfileRepository;
import com.musician.api.repository.UserRepository;
import com.musician.api.request.UpdateProfileRequest;
import com.musician.api.response.UserProfileResponse;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users/{id}/profile")
@RequiredArgsConstructor
public class UserProfileController {

  private final UserRepository userRepository;
  private final UserProfileRepository userProfileRepository;

  @PatchMapping
  public UserProfileResponse updateUserProfile(
      @PathVariable Long id, @Valid @RequestBody UpdateProfileRequest updateProfileRequest) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    String username = authentication.getName();

    User user =
        userRepository
            .findByUsername(username)
            .orElseThrow(() -> new UnauthorizedException("User not found"));

    if (!user.getId().equals(id)) {
      throw new UnauthorizedException("You do not have permission to update this profile.");
    }

    UserProfile profile = getUserProfile(updateProfileRequest, user);

    userProfileRepository.save(profile);

    return new UserProfileResponse(profile);
  }

  private static UserProfile getUserProfile(UpdateProfileRequest updateProfileRequest, User user) {
    UserProfile profile = user.getProfile();

    if (profile == null) {
      throw new EntityNotFoundException("Profil introuvable pour cet utilisateur");
    }

    if (!updateProfileRequest.getProfileName().isEmpty()) {
      profile.setProfileName(updateProfileRequest.getProfileName());
    }
    if (!updateProfileRequest.getDescription().isEmpty()) {
      profile.setDescription(updateProfileRequest.getDescription());
    }
    if (!updateProfileRequest.getPlayedInstruments().isEmpty()) {
      profile.setPlayedInstruments(updateProfileRequest.getPlayedInstruments());
    }
    if (!updateProfileRequest.getMusicalInfluences().isEmpty()) {
      profile.setMusicalInfluences(updateProfileRequest.getMusicalInfluences());
    }

    return profile;
  }
}
