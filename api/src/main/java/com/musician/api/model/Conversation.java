package com.musician.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "conversations")
@Builder
@AllArgsConstructor
public class Conversation {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToMany(fetch = FetchType.LAZY)
  @OnDelete(action = OnDeleteAction.CASCADE)
  @JoinTable(
      name = "users_conversations",
      joinColumns = {@JoinColumn(name = "CONVERSATION_ID", referencedColumnName = "ID")},
      inverseJoinColumns = {@JoinColumn(name = "USER_ID", referencedColumnName = "ID")})
  @JsonIgnoreProperties(value = {"conversations"})
  private List<User> participants = new ArrayList<>();

  @OneToMany(fetch = FetchType.LAZY)
  @JoinColumn(name = "conversation_id")
  private List<Message> messages = new ArrayList<>();

  public Conversation() {}

  public List<Message> messages() {
    return messages;
  }

  public List<User> participants() {
    return participants;
  }
}
