package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.UserRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostServiceImpl postService;


    @Override
    public User findById(int id) {
        return userRepository.findById(id).orElseThrow(RuntimeException::new);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElseThrow(RuntimeException::new);
    }

    @Override
    public void save(User user) {
        userRepository.save(user);
    }


    @Override
    public Post addBookToUser(String bookId, int userId) {
        return postService.add(bookId, userId);
    }

    @Override
    public Post removeBookFromUser(String bookId, int userId) {
        return postService.delete(bookId, userId);
    }

    @Override
    public List<Book> getUserBooksByUserId(int userId) {
        return postService.getBooksByUserId(userId);
    }

}
