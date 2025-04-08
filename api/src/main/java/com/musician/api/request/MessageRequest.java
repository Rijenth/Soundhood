package com.musician.api.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class MessageRequest {

  @NotBlank(message = "Message is required")
  @Size(min = 1, max = 500, message = "Message must be between 1 and 500 characters")
  private String message;

  //    @NotBlank(message = "Conversation ID is required")
  //    private Long conversationId;

  @NotBlank(message = "Sender ID is required")
  private Long userId;
}
