package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.UserBook;

import java.util.List;

public interface UserBookService {
    UserBook add(String bookId, int userId);
    UserBook delete(String bookId, int userId);
    List<Book> getBooksByUserId(int userId);
}
