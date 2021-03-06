package com.swe.bookie.dao;

import com.swe.bookie.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface BookRepository extends JpaRepository<Book, Integer> {
    Book getById(String id);

    List<Book> getAllByIdIn(List<String> ids);
}
