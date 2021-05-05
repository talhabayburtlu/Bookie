package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;

import java.util.List;

public interface PostService {
    Post add(String bookId, int userId);

    Post delete(String bookId, int userId);

    Post getById(int id);

    List<Book> getBooksByUserId(int userId);

    Comment toComment(User sender, int postId, String description);

    List<Comment> getAllByPostId(int postId);

    Post updatePostStatus(int postId, String status, User user);
}
