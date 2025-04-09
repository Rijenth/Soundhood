package com.musician.api.repository;

import com.musician.api.model.User;
import com.musician.api.model.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserProfileRepository extends JpaRepository<UserProfile, Long> {
}
