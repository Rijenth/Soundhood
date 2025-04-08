package com.musician.api.response;

import com.musician.api.model.Event;
import com.musician.api.model.User;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class EventResponse {
    private Long id;
    private String name;
    private LocalDate startDate;
    private LocalDate endDate;
    private String location;
    private String description;
    private int maxParticipant;
    private UserResponse createdBy;
    private List<UserResponse> participants;

    public EventResponse(Event event) {
        this.id = event.getId();
        this.name = event.getName();
        this.startDate = event.getStartDate();
        this.endDate = event.getEndDate();
        this.location = event.getLocation();
        this.description = event.getDescription();
        this.maxParticipant = event.getMaxParticipant();
        this.createdBy = new UserResponse(event.getCreatedBy());
        this.participants = event.getParticipants().stream().map(UserResponse::new).collect(Collectors.toList());
    }
}