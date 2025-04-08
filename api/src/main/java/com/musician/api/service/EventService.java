package com.musician.api.service;

import com.musician.api.model.Event;
import com.musician.api.model.User;
import com.musician.api.request.CreateEventRequest;
import com.musician.api.repository.EventRepository;
import com.musician.api.repository.UserRepository;
import com.musician.api.exception.EventNotFoundException;
import com.musician.api.exception.UserNotFoundException;
import com.musician.api.exception.EventFullException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {
    private final EventRepository eventRepository;
    private final UserRepository userRepository;

    public EventService(EventRepository eventRepository, UserRepository userRepository) {
        this.eventRepository = eventRepository;
        this.userRepository = userRepository;
    }

    public Event createEvent(CreateEventRequest request, User user) {
        Event event = new Event();
        event.setName(request.getName());
        event.setStartDate(request.getStartDate());
        event.setEndDate(request.getEndDate());
        event.setLocation(request.getLocation());
        event.setDescription(request.getDescription());
        event.setMaxParticipant(request.getMaxParticipant());
    
        // Set the 'createdBy' field to the authenticated user
        event.setCreatedBy(user);
    
        // Save and return the event
        return eventRepository.save(event);
    }

    public Event getEventById(Long id) {
        return eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
    }
    
    public List<Event> findAllEvents() {
            Iterable<Event> events = eventRepository.findAll();
    
            return (List<Event>) events;
        }


    public Event updateEvent(Long id, CreateEventRequest request) {
        Event event = getEventById(id);
        event.setName(request.getName());
        event.setStartDate(request.getStartDate());
        event.setEndDate(request.getEndDate());
        event.setLocation(request.getLocation());
        event.setDescription(request.getDescription());
        event.setMaxParticipant(request.getMaxParticipant());
        // Save updated event
        return eventRepository.save(event);
    }

    public Event addParticipant(Long eventId, Long userId) {
        Event event = getEventById(eventId);
        User user = userRepository.findById(userId).orElseThrow(() -> new UserNotFoundException(userId));

        if (event.getParticipants().size() >= event.getMaxParticipant()) {
            throw new EventFullException(eventId);
        }

        event.getParticipants().add(user);
        eventRepository.save(event);
        return event;
    }

    public List<Event> getEventsByParticipant(Long userId) {
        return eventRepository.findByParticipants_Id(userId);
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }
}
