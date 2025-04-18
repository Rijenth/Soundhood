package com.musician.api.repository;

import com.musician.api.model.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
  Optional<User> findByUsername(String username);

  Optional<User> findByEmailAddress(String email);

  Optional<User> findById(Long id);

  List<User> findByUsernameNot(String username);
}
