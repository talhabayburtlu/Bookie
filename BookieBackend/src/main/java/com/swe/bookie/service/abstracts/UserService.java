package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;

import java.util.List;

public interface UserService {
    User findById(int id);

    User findByEmail(String email);

    void save(User user);

    Post addBookToUser(String bookId, int userId);

    Post removeBookFromUser(String bookId, int userId);

    List<Book> getUserBooksByUserId(int userId);
}
