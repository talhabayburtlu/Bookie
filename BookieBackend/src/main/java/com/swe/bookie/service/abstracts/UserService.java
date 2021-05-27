package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.resource.HomepagePostResponse;

import java.util.List;

public interface UserService {
    User findById(int id);

    User findByEmail(String email);

    void save(User user);

    Post addBookToUser(String bookId, User user);

    Post removeBookFromUser(String bookId, User user);

    List<Book> getUserBooksByUserId(int userId);

    Comment toComment(int userId, int postId, String description);

    User getByEmail(String email);

    Comment deleteComment(int userId, int commentId);

    List<Book> getLibraryByUserId(int userId);

    List<Post> getPostByUserId(int userId);

    List<User> getUsersByCity(String city);

    List<HomepagePostResponse> getHomepagePostsByUserId(int userId);
}
