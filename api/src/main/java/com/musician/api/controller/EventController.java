package com.musician.api.controller;

import com.musician.api.exception.UnauthorizedException;
import com.musician.api.model.Event;
import com.musician.api.model.User;
import com.musician.api.repository.UserRepository;
import com.musician.api.request.CreateEventRequest;
import com.musician.api.response.EventResponse;
import com.musician.api.service.EventService;
import jakarta.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/events")
public class EventController {
  private final EventService eventService;
  private final UserRepository userRepository;

  public EventController(EventService eventService, UserRepository userRepository) {
    this.eventService = eventService;
    this.userRepository = userRepository;
  }

  @GetMapping
  public List<EventResponse> getAllEvent() {
    List<Event> events = eventService.findAllEvents();
    List<EventResponse> response =
        events.stream().map(EventResponse::new).collect(Collectors.toList());
    return response;
  }

  @PostMapping
  public EventResponse createEvent(@Valid @RequestBody CreateEventRequest request) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

    if (authentication == null || !authentication.isAuthenticated()) {
      throw new UnauthorizedException("You must be authenticated to access this resource.");
    }

    String username = authentication.getName();

    User user =
        userRepository
            .findByUsername(username)
            .orElseThrow(() -> new UnauthorizedException("User not found"));

    // Pass both CreateEventRequest and the authenticated User to the service
    Event event = eventService.createEvent(request, user);

    return new EventResponse(event);
  }

  @GetMapping("/{id}")
  public EventResponse getEvent(@PathVariable Long id) {
    Event event = eventService.getEventById(id);
    return new EventResponse(event);
  }

  @PutMapping("/{id}")
  public EventResponse updateEvent(
      @PathVariable Long id, @Valid @RequestBody CreateEventRequest request) {
    Event updatedEvent = eventService.updateEvent(id, request);
    return new EventResponse(updatedEvent);
  }

  @PutMapping("/{eventId}/add-participant/{userId}")
  public EventResponse addParticipant(@PathVariable Long eventId, @PathVariable Long userId) {
    Event event = eventService.addParticipant(eventId, userId);
    return new EventResponse(event);
  }

  @GetMapping("/participations/{userId}")
  public ResponseEntity<List<EventResponse>> getEventsByParticipant(@PathVariable Long userId) {
    List<Event> events = eventService.getEventsByParticipant(userId);
    List<EventResponse> response =
        events.stream().map(EventResponse::new).collect(Collectors.toList());
    return ResponseEntity.ok(response);
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
    eventService.deleteEvent(id);
    return ResponseEntity.noContent().build();
  }
}
