package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.User;
import com.swe.bookie.entity.UserBook;

import java.util.List;

public interface UserService {
    User findById(int id);

    User findByEmail(String email);

    void save(User user);

    UserBook addBookToUser(String bookId, int userId);

    UserBook removeBookFromUser(String bookId, int userId);

    List<Book> getUserBooksByUserId(int userId);
}
