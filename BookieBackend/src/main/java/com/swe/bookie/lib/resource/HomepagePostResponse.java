package com.swe.bookie.lib.resource;

import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.User;
import lombok.Data;

import java.util.List;

@Data
public class HomepagePostResponse {
   private User user;
   private List<Book> books;
}
