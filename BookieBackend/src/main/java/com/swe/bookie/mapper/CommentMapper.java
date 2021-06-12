package com.swe.bookie.mapper;

import com.swe.bookie.entity.Comment;
import com.swe.bookie.lib.resource.CommentResponse;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class CommentMapper {

    private final ModelMapper modelMapper = new ModelMapper();

    public CommentResponse toResource(Comment comment) {
        CommentResponse commentResponse = modelMapper.map(comment, CommentResponse.class);
        commentResponse.setPostId(comment.getPost().getId());
        commentResponse.setSenderId(comment.getSender().getId());
        commentResponse.setSenderName(comment.getSender().getFullname());
        return commentResponse;
    }

}
