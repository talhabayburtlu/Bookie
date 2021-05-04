package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Post;

import java.util.List;

public interface PostService {
    Post add(String bookId, int userId);

    Post delete(String bookId, int userId);

    List<Book> getBooksByUserId(int userId);
}
