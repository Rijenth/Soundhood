package com.musician.api.model;

import jakarta.persistence.*;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

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

  @Builder.Default
  @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
  private UserProfile profile;

  public User() {}

  @PrePersist
  public void generateUsername() {
    String uniqueSuffix = UUID.randomUUID().toString().substring(0, 8);
    this.username = firstName + lastName + uniqueSuffix;
  }
}
