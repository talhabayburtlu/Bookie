package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;

import java.util.List;

public interface CommentService {
    List<Comment> getAllByPost(Post post);
    Comment add(User sender, Post post, String description);
    Comment delete(User sender, int commentId);
}
