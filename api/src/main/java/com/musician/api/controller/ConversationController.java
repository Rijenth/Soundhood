package com.musician.api.controller;

import com.musician.api.model.Conversation;
import com.musician.api.repository.ConversationRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/conversations")
public class ConversationController {

    private final ConversationRepository conversationRepository;

    public ConversationController(ConversationRepository conversationRepository) {
        this.conversationRepository = conversationRepository;
    }

    @GetMapping("/{conversationId}")
    public Conversation getConversation(@PathVariable String conversationId) {
        return conversationRepository.findById(Long.parseLong(conversationId))
                .orElseThrow(() -> new RuntimeException("Conversation not found"));
    }
}
