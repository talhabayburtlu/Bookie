package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.CommentRepository;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.service.abstracts.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    CommentRepository commentRepository;


    @Override
    public List<Comment> getAllByPost(Post post) {
        return commentRepository.getAllByPost(post);
    }

    @Override
    public Comment add(User sender, Post post, String description) {

        Comment commentToAdd = new Comment();
        commentToAdd.setSender(sender);
        commentToAdd.setPost(post);
        commentToAdd.setDescription(description);

        return commentRepository.save(commentToAdd);
    }

    @Override
    public Comment delete(User sender, int commentId) {
        Comment commentToDelete = commentRepository.getById(commentId);

        if (commentToDelete.getSender().getId() != sender.getId())
            return null;
        commentRepository.deleteById(commentId);
        return commentToDelete;
    }


}
