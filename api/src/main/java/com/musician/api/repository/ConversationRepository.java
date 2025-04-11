package com.musician.api.repository;

import com.musician.api.model.Conversation;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ConversationRepository extends JpaRepository<Conversation, Long> {

  @Query(
      "SELECT c FROM Conversation c JOIN c.participants p1 JOIN c.participants p2 "
          + "WHERE p1.id = :userId1 AND p2.id = :userId2")
  Optional<Conversation> findConversationBetweenUsers(
      @Param("userId1") Long userId1, @Param("userId2") Long userId2);
}
