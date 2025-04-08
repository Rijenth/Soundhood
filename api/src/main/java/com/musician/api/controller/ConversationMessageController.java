package com.musician.api.controller;

import com.musician.api.model.Message;
import com.musician.api.repository.ConversationRepository;
import com.musician.api.repository.MessageRepository;
import com.musician.api.request.MessageRequest;
import com.musician.api.response.ConversationMessageResponse;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/conversations/{conversationId}/messages")
public class ConversationMessageController {

    private final ConversationRepository conversationRepository;

    private final MessageRepository messageRepository;

    public ConversationMessageController(
            ConversationRepository conversationRepository,
            MessageRepository messageRepository
    ) {
        this.conversationRepository = conversationRepository;
        this.messageRepository = messageRepository;
    }

    @GetMapping
    public List<ConversationMessageResponse> index(@PathVariable Long conversationId) {
        conversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found"));

        var messages = messageRepository.findByConversationId(Math.toIntExact(conversationId));

        return messages.stream()
                .map(ConversationMessageResponse::new)
                .toList();
    }

    @PostMapping
    public ConversationMessageResponse create(
            @PathVariable Long conversationId,
            @Valid @RequestBody MessageRequest messageRequest
    ) {
        conversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found"));

        // Créer un nouveau message avec le builder
        var message = Message.builder()
                .content(messageRequest.getMessage())
                .conversationId(conversationId.intValue())
                .user_id(messageRequest.getUserId().intValue())
                .build();

        // Sauvegarder le message
        message = messageRepository.save(message);

        // Retourner la réponse
        return new ConversationMessageResponse(message);
    }
}
