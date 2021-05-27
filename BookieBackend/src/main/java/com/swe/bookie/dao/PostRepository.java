package com.swe.bookie.dao;

import com.swe.bookie.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Integer> {
    Post getByBookIdAndUserId(String bookId, int userId);

    Post getById(int id);

    List<Post> getAllByUserId(int userId);

    Post deleteById(int id);

    Post deleteByBookIdAndUserId(String bookId, int userId);

}
