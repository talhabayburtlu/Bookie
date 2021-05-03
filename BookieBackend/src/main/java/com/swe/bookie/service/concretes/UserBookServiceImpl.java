package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.UserBookRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.UserBook;
import com.swe.bookie.service.abstracts.UserBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserBookServiceImpl implements UserBookService {

    @Autowired
    private UserBookRepository userBookRepository;

    @Autowired
    private BookServiceImpl bookService;

    @Override
    public UserBook add(String bookId, int userId) {
        UserBook userBookToAdd = new UserBook();
        userBookToAdd.setUserId(userId);
        userBookToAdd.setBookId(bookId);
        return userBookRepository.save(userBookToAdd);
    }

    @Override
    public UserBook delete(String bookId, int userId) {
        return userBookRepository.deleteByBookIdAndUserId(bookId, userId);
    }

    @Override
    public List<Book> getBooksByUserId(int userId) {
        List<UserBook> userBooks = userBookRepository.getAllByUserId(userId);
        List<String> bookIds = userBooks.stream().map(UserBook::getBookId).collect(Collectors.toList());
        return bookService.getAllById(bookIds);
    }
}
