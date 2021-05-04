package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Book;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

public interface BookService {
    Book getById(String id);

    List<Book> getAllById(List<String> ids);

    List<Book> searchForBooks(String title) throws URISyntaxException, IOException;
}
