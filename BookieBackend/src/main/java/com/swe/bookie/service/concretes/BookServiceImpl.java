package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.BookRepository;
import com.swe.bookie.entity.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class BookServiceImpl {
    @Autowired
    private BookRepository bookRepository;

    public Book getById(String id){
        return bookRepository.getById(id);
    }

    public List<Book> getAllById(List<String> ids){
        return bookRepository.getAllByIdIn(ids);
    }
}
