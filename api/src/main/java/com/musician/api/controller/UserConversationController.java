package com.musician.api.controller;

import com.musician.api.model.Conversation;
import com.musician.api.model.User;
import com.musician.api.repository.ConversationRepository;
import com.musician.api.repository.UserRepository;
import com.musician.api.response.ConversationResponse;
import com.musician.api.response.UserConversationResponse;
import jakarta.validation.Valid;
import lombok.Getter;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/users/{userId}/conversations")
public class UserConversationController {

    private final ConversationRepository conversationRepository;
    private final UserRepository userRepository;

    public UserConversationController(
            ConversationRepository conversationRepository,
            UserRepository userRepository
    ) {
        this.conversationRepository = conversationRepository;
        this.userRepository = userRepository;
    }

    @GetMapping
    public List<ConversationResponse> getUserConversations(@PathVariable Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        return user.getConversations().stream()
                .map(ConversationResponse::new)
                .collect(Collectors.toList());
    }

    @PostMapping
    public ConversationResponse createConversation(@PathVariable Long userId, @Valid @RequestBody User otherUser) {
        // Vérifier que l'utilisateur existe
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Vérifier que l'autre utilisateur existe
        User secondUser = userRepository.findById(otherUser.getId())
                .orElseThrow(() -> new IllegalArgumentException("Other user not found"));

        // Vérifie si l'utilisateur essaie de créer une conversation avec lui-même
        if (userId.equals(secondUser.getId())) {
            throw new IllegalArgumentException("Cannot create a conversation with yourself");
        }

        // Vérifier si une conversation existe déjà entre les deux utilisateurs
        Optional<Conversation> existingConversation = conversationRepository.findConversationBetweenUsers(userId, secondUser.getId());
        if (existingConversation.isPresent()) {
            return new ConversationResponse(existingConversation.get());
        }

        // Créer une nouvelle conversation
        Conversation conversation = new Conversation();
        List<User> participants = new ArrayList<>();
        participants.add(user);
        participants.add(secondUser);

        conversation.setParticipants(participants);
        Conversation savedConversation = conversationRepository.save(conversation);

        // Retourner une réponse formatée
        return new ConversationResponse(savedConversation);
    }

    @GetMapping("/{conversationId}/participants")
    public List<UserConversationResponse> getConversationParticipants(
            @PathVariable Long userId,
            @PathVariable Long conversationId
    ) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found"));

        // Vérifier que l'utilisateur est bien un participant de cette conversation
        if (!conversation.getParticipants().contains(user)) {
            throw new IllegalArgumentException("User is not a participant in this conversation");
        }

        // Utiliser distinct pour éviter les doublons
        return conversation.getParticipants().stream()
                .distinct()
                .map(UserConversationResponse::new)
                .collect(Collectors.toList());
    }
}