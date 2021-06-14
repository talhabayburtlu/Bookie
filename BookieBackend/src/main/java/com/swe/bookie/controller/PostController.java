package com.swe.bookie.controller;

import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.PostStatusUpdateDTO;
import com.swe.bookie.lib.resource.CommentResponse;
import com.swe.bookie.mapper.CommentMapper;
import com.swe.bookie.service.abstracts.PostService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/post")
public class PostController {

    private final PostService postService;
    private final UserService userService;
    private final CommentMapper commentMapper;

    @Autowired
    public PostController(PostService postService, UserService userService, CommentMapper commentMapper) {
        this.postService = postService;
        this.userService = userService;
        this.commentMapper = commentMapper;
    }

    @PostMapping("/status")
    public Post updatePostStatus(@RequestBody PostStatusUpdateDTO postStatusUpdateDTO) throws Exception {
        org.springframework.security.core.userdetails.User securityUser = // Getting authenticated user details.
                (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.findByEmail(securityUser.getUsername()); // Getting authenticated user by using user details.

        return postService.updatePostStatus(user.getId(), postStatusUpdateDTO.getBookId(), postStatusUpdateDTO.getStatus(), user);
    }

    @GetMapping("/getCommentsByUserIdAndBookId")
    public List<CommentResponse> getCommentsByUserIdAndBookId(@RequestParam("userId") int userId, @RequestParam("bookId") String bookId) {
        List<Comment> comments = postService.getCommentsByUserIdAndBookId(userId, bookId);
        return comments.stream().map(c -> commentMapper.toResource(c)).collect(Collectors.toList());
    }

    @GetMapping("/getCommentsByPostId")
    public List<CommentResponse> getCommentsByPostId(@RequestParam("postId") int postId) {
        List<Comment> comments = postService.getAllByPostId(postId);
        return comments.stream().map(c -> commentMapper.toResource(c)).collect(Collectors.toList());
    }

}
