package com.swe.bookie.dao;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.UserBook;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserBookRepository extends JpaRepository<UserBook, Integer> {
    UserBook getByBookIdAndUserId(String bookId, int userId);
    List<UserBook> getAllByUserId(int userId);
    UserBook deleteByBookIdAndUserId(String bookId, int userId);

}
