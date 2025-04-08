package com.musician.api.request;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CreateConversationRequest {
    private Long otherUserId;
}
