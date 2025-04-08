package com.musician.api.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "messages")
@Builder
@AllArgsConstructor
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String content;

    @Getter
    @Column(nullable = false, name = "conversation_id")
    private Integer conversationId;

    @Column(nullable = false)
    private Integer user_id;

    public Message() {}


//    @Column(nullable = false)
//    @Temporal(TemporalType.TIMESTAMP)
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Europe/Paris")
//    @CreationTimestamp
//    private Date created_at;
//
//    @Column(nullable = false)
//    private Date received_at;

}
