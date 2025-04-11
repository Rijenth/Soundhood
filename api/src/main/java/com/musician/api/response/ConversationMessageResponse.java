package com.musician.api.response;

import com.musician.api.model.Message;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ConversationMessageResponse {
  private Long id;
  private String content;
  private Long conversation_id;
  private Long user_id;

  public ConversationMessageResponse(Message message) {
    this.id = message.getId();
    this.content = message.getContent();
    this.conversation_id = Long.valueOf(message.getConversationId());
    this.user_id = Long.valueOf(message.getUser_id());
  }
}
