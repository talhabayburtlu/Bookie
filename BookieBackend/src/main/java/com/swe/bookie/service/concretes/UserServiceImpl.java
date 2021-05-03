package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.UserRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.User;
import com.swe.bookie.entity.UserBook;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserBookServiceImpl userBookService;


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
    public UserBook addBookToUser(String bookId, int userId) {
        return userBookService.add(bookId, userId);
    }

    @Override
    public UserBook removeBookFromUser(String bookId, int userId) {
        return userBookService.delete(bookId, userId);
    }

    @Override
    public List<Book> getUserBooksByUserId(int userId) {
        return userBookService.getBooksByUserId(userId);
    }

}
