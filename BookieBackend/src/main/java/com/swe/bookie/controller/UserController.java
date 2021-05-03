package com.swe.bookie.controller;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.UserBook;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;


    @PostMapping("addBook/{userId}/{bookId}")
    public UserBook addBook(@PathVariable(value = "userId") int userId, @PathVariable(value = "bookId") String bookId ) {
        return userService.addBookToUser(bookId, userId);
    }

    @DeleteMapping("deleteBook/{userId}/{bookId}")
    public UserBook removeBook(@PathVariable(value = "userId") int userId, @PathVariable(value = "bookId") String bookId ) {
        return userService.removeBookFromUser(bookId, userId);
    }

    @GetMapping("getBooks/{userId}")
    List<Book> getBooksByUserId(@PathVariable(value = "userId") int userId){
        return userService.getUserBooksByUserId(userId);
    }
}
