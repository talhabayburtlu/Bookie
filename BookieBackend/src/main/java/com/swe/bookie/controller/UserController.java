package com.swe.bookie.controller;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Post;
import com.swe.bookie.service.abstracts.BookService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private BookService bookService;


    @PostMapping("addBook/{userId}/{bookId}")
    public Post addBook(@PathVariable(value = "userId") int userId, @PathVariable(value = "bookId") String bookId) throws IOException, URISyntaxException {
        Book book = bookService.getById(bookId);
        if (book == null) { // If book doesn't exist in database , create from Google Books and store in database.
            bookService.createBook(bookId);
        }

        return userService.addBookToUser(bookId, userId);
    }

    @DeleteMapping("deleteBook/{userId}/{bookId}")
    public Post removeBook(@PathVariable(value = "userId") int userId, @PathVariable(value = "bookId") String bookId) {
        return userService.removeBookFromUser(bookId, userId);
    }

    @GetMapping("getBooks/{userId}")
    List<Book> getBooksByUserId(@PathVariable(value = "userId") int userId){
        return userService.getUserBooksByUserId(userId);
    }

}
