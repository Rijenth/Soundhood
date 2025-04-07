package com.musician.api.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AuthenticationRequest {
    @NotBlank(message = "Password is required")
    @Size(min=4)
    private String password;

    @JsonProperty("first_name")
    @NotBlank(message = "First name is required")
    @Size(min=4)
    private String firstName;

    @JsonProperty("last_name")
    @NotBlank(message = "Last name is required")
    @Size(min=4)
    private String lastName;
}
