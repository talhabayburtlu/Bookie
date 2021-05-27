package com.swe.bookie.controller;

import com.swe.bookie.entity.Book;
import com.swe.bookie.service.abstracts.AuthService;
import com.swe.bookie.service.abstracts.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;

@RestController
@RequestMapping("/book")
public class BookController {

    private final BookService bookService;
    private final AuthService authService;

    @Autowired
    public BookController(BookService bookService, AuthService authService) {
        this.bookService = bookService;
        this.authService = authService;
    }

    @GetMapping("/search")
    public ArrayList<Book> searchForBooks(@RequestParam String title) throws IOException, URISyntaxException {
        return (ArrayList<Book>) this.bookService.searchForBooks(title, authService.getAuthenticatedUser());
    }

}
