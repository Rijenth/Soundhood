package com.musician.api.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Builder
@Setter
@Getter
@Entity
@Table(name = "users")
@AllArgsConstructor
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String password;

  @Column(nullable = false)
  private String firstName;

  @Column(nullable = false)
  private String lastName;

  @Column(nullable = false, unique = true)
  private String emailAddress;

  @Column(nullable = false, unique = true)
  private String username;

  @Column(nullable = false, columnDefinition = "boolean default false")
  private Boolean isOnline;

  @Builder.Default
  @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
  private UserProfile profile;

  @Setter
  @ManyToMany(fetch = FetchType.LAZY)
  @OnDelete(action = OnDeleteAction.CASCADE)
  @JoinTable(
          name="users_conversations",
          joinColumns={@JoinColumn(name="USER_ID", referencedColumnName="ID")},
          inverseJoinColumns={@JoinColumn(name="CONVERSATION_ID", referencedColumnName="ID")}
  )
  @JsonIgnoreProperties(value = {"participants", "messages"})
  private List<Conversation> conversations = new ArrayList<>();

  public User() {}

  @PrePersist
  public void generateUsername() {
    String uniqueSuffix = UUID.randomUUID().toString().substring(0, 8);
    this.username = firstName + lastName + uniqueSuffix;
  }
}
