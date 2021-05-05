package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.CommentRepository;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl {
    @Autowired
    CommentRepository commentRepository;


    List<Comment> getAllByPost(Post post) {
        return commentRepository.getAllByPost(post);
    }

    Comment add(User sender, Post post, String description) {

        Comment commentToAdd = new Comment();
        commentToAdd.setSender(sender);
        commentToAdd.setPost(post);
        commentToAdd.setDescription(description);

        return commentRepository.save(commentToAdd);
    }

}
