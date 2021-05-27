package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.User;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

public interface BookService {
    Book getById(String id);

    List<Book> getAllById(List<String> ids);

    List<Book> searchForBooks(String title, User user) throws URISyntaxException, IOException;

    Book createBook(String id) throws URISyntaxException, IOException;

}
