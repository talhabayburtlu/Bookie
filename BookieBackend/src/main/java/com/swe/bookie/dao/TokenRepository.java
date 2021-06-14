package com.swe.bookie.dao;

import com.swe.bookie.entity.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface TokenRepository extends JpaRepository<Token, Integer> {
    @Query(value = "SELECT * FROM token WHERE user_id = :userId", nativeQuery = true)
    Optional<Token> findByUserId(@Param("userId") int userId);
}
