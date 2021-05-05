package com.swe.bookie.dao;

import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
    List<Comment> getAllByPost(Post post);

    void deleteById(int id);
}
