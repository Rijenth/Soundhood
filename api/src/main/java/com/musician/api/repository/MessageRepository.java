package com.musician.api.repository;

import com.musician.api.model.Message;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessageRepository extends JpaRepository<Message, Long> {
  List<Message> findByConversationId(Integer conversationId);
}
