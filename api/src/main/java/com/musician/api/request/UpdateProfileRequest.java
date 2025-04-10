package com.musician.api.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class UpdateProfileRequest {
  @JsonProperty("profile_name")
  @Size(min = 2)
  private String profileName;

  @JsonProperty("played_instruments")
  private String playedInstruments;

  @JsonProperty("musical_influences")
  private String musicalInfluences;

  @JsonProperty("description")
  private String description;
}
