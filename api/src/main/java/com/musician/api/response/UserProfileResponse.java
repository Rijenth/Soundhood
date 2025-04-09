package com.musician.api.response;

import com.musician.api.model.UserProfile;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserProfileResponse {
  private Long id;
  private String profileName;
  private String description;
  private String playedInstruments;
  private String musicalInfluences;

  public UserProfileResponse(UserProfile profile) {
    this.id = profile.getId();
    this.profileName = profile.getProfileName();
    this.description = profile.getDescription();
    this.playedInstruments = profile.getPlayedInstruments();
    this.musicalInfluences = profile.getMusicalInfluences();
  }
}
