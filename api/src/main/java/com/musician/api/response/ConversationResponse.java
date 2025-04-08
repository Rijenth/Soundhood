package com.musician.api.response;

import com.musician.api.model.Conversation;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;

@Getter
public class ConversationResponse {
  private final Long id;
  private List<UserConversationResponse> participants = new ArrayList<>();

  public ConversationResponse(Conversation conversation) {
    this.id = conversation.getId();
    // Utiliser une collection unique pour éviter les doublons
    this.participants =
        conversation.getParticipants().stream()
            .distinct()
            .map(UserConversationResponse::new)
            .collect(Collectors.toList());
  }
}
