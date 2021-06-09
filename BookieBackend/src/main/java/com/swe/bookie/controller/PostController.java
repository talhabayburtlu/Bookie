package com.swe.bookie.controller;

import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.PostStatusUpdateDTO;
import com.swe.bookie.service.abstracts.PostService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/post")
public class PostController {

    private final PostService postService;
    private final UserService userService;

    @Autowired
    public PostController(PostService postService, UserService userService) {
        this.postService = postService;
        this.userService = userService;
    }

    @PostMapping("/status")
    public Post updatePostStatus(@RequestBody PostStatusUpdateDTO postStatusUpdateDTO) throws IOException, URISyntaxException {
        org.springframework.security.core.userdetails.User securityUser = // Getting authenticated user details.
                (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.findByEmail(securityUser.getUsername()); // Getting authenticated user by using user details.

        return postService.updatePostStatus(postStatusUpdateDTO.getPostId(), postStatusUpdateDTO.getStatus(), user);
    }

    @GetMapping("/getCommentsByUserIdAndBookId")
    public List<Comment> getCommentsByUserIdAndBookId(@RequestParam("userId") int userId, @RequestParam("bookId") String bookId) {
        return postService.getCommentsByUserIdAndBookId(userId, bookId);
    }

    @GetMapping("/getCommentsByPostId")
    public List<Comment> getCommentsByPostId(@RequestParam("postId") int postId) {
        return postService.getAllByPostId(postId);
    }

}
