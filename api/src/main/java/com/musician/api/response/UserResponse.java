package com.musician.api.response;

import com.musician.api.model.User;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserResponse {
  private Long id;
  private String firstName;
  private String lastName;
  private String username;
  private String emailAddress;

  public UserResponse(User user) {
    this.id = user.getId();
    this.firstName = user.getFirstName();
    this.lastName = user.getLastName();
    this.username = user.getUsername();
    this.emailAddress = user.getEmailAddress();
  }
}
