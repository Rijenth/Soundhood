package com.musician.api.response;

import com.musician.api.model.User;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserConversationResponse {
  private Long id;
  private String username;
  private String firstName;
  private String lastName;
  private String emailAddress;

  public UserConversationResponse(User user) {
    this.id = user.getId();
    this.username = user.getUsername();
    this.firstName = user.getFirstName();
    this.lastName = user.getLastName();
    this.emailAddress = user.getEmailAddress();
  }
}
