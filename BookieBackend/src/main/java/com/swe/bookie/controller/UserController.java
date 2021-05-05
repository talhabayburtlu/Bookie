package com.swe.bookie.controller;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.service.abstracts.BookService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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


    @PostMapping("/addBook/{userId}/{bookId}")
    public Post addBook(@AuthenticationPrincipal User user, @PathVariable(value = "bookId") String bookId) throws IOException, URISyntaxException {
        Book book = bookService.getById(bookId);
        if (book == null) { // If book doesn't exist in database , create from Google Books and store in database.
            bookService.createBook(bookId);
        }

        return userService.addBookToUser(bookId, user.getId());
    }

    @DeleteMapping("/deleteBook//{bookId}")
    public Post removeBook(@AuthenticationPrincipal User user, @PathVariable(value = "bookId") String bookId) {
        return userService.removeBookFromUser(bookId, user.getId());
    }

    @GetMapping("/getBooks")
    List<Book> getBooksByUserId(@AuthenticationPrincipal User user){
        return userService.getUserBooksByUserId(user.getId());
    }

    @PostMapping("/toComment")
    Comment toComment(@AuthenticationPrincipal User user, String postId, String description ){
        return userService.toComment(user.getId(),postId,description);
    }
}
