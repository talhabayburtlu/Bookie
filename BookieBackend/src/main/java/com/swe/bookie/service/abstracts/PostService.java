package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;

import java.util.List;

public interface PostService {
    Post add(String bookId, User user);

    Post delete(String bookId, User user);

    Post getById(int id);

    Post getByUserIdAndBookId(int userId, String bookId);

    List<Book> getBooksByUserId(int userId);

    Comment toComment(User sender, int ownerId, String bookId, String description);

    List<Comment> getAllByPostId(int postId);

    List<Comment> getCommentsByUserIdAndBookId(int userId, String bookId);

    List<Post> getAllPostsByUserId(int userId);

    Post updatePostStatus(int userId, String bookId, String status, User user);
}
