package com.musician.api.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "user_profiles")
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

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
}
