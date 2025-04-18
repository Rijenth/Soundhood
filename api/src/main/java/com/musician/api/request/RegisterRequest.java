package com.musician.api.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class RegisterRequest extends AuthenticationRequest {
  @JsonProperty("first_name")
  @NotBlank(message = "First name is required")
  @Size(min = 2)
  private String firstName;

  @JsonProperty("last_name")
  @NotBlank(message = "Last name is required")
  @Size(min = 2)
  private String lastName;

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
