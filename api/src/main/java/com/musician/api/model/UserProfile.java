package com.musician.api.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

@Builder
@Setter
@Getter
@Entity
@Table(name = "user_profiles")
@AllArgsConstructor
public class UserProfile {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String profileName;

  @Column(length = 1000)
  private String description;

  @Column(length = 255)
  private String playedInstruments;

  @Column(length = 255)
  private String musicalInfluences;

  @OneToOne
  @JoinColumn(name = "user_id", nullable = false)
  @JsonIgnore
  private User user;

  public UserProfile() {}
}
