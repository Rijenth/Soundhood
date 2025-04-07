package com.musician.api.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class AuthenticationRequest {
  @NotBlank(message = "Email address is required")
  @Email
  private String emailAddress;

  @NotBlank(message = "Password is required")
  @Size(min = 4)
  private String password;
}
