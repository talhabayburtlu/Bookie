package com.swe.bookie.dao;

import com.swe.bookie.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);

    User getById(int id);

    User getByEmail(String email);

    List<User> getByAddress_City(String city);


}
