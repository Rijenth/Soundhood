package com.musician.api.repository;

import com.musician.api.model.Event;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    Optional<Event> findByName(String name);
    
     List<Event> findByParticipants_Id(Long userId);
}
