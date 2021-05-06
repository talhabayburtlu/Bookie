package com.swe.bookie.controller;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.resource.UserResource;
import com.swe.bookie.mapper.UserMapper;
import com.swe.bookie.service.abstracts.BookService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder bcryptEncoder;


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
    List<Book> getBooksByUserId(@AuthenticationPrincipal User user) {
        return userService.getUserBooksByUserId(user.getId());
    }

    @PostMapping("/toComment")
    Comment toComment(@AuthenticationPrincipal User user, int postId, String description) {
        return userService.toComment(user.getId(), postId, description);
    }

    @GetMapping("/me")
    public UserResource getMyDetails() {
        org.springframework.security.core.userdetails.User securityUser = // Getting authenticated user details.
                (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.findByEmail(securityUser.getUsername()); // Getting authenticated user by using user details.

        return userMapper.toResource(user);
    }

    @PutMapping("/me")
    public UserResource updateMyDetails(@RequestBody UserDTO userDTO) {
        org.springframework.security.core.userdetails.User securityUser = // Getting authenticated user details.
                (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.findByEmail(securityUser.getUsername()); // Getting authenticated user by using user details.

        User updatedUser = userMapper.toEntity(userDTO, user);
        updatedUser.setPassword(bcryptEncoder.encode(updatedUser.getPassword()));

        userService.save(updatedUser);
        return userMapper.toResource(updatedUser);
    }

}
