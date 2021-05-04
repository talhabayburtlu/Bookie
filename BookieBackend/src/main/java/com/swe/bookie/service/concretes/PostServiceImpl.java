package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.PostRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Post;
import com.swe.bookie.service.abstracts.BookService;
import com.swe.bookie.service.abstracts.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private BookService bookService;

    @Override
    public Post add(String bookId, int userId) {
        Post userBookToAdd = new Post();
        userBookToAdd.setUserId(userId);
        userBookToAdd.setBookId(bookId);
        return postRepository.save(userBookToAdd);
    }

    @Override
    public Post delete(String bookId, int userId) {
        return postRepository.deleteByBookIdAndUserId(bookId, userId);
    }

    @Override
    public List<Book> getBooksByUserId(int userId) {
        List<Post> userBooks = postRepository.getAllByUserId(userId);
        List<String> bookIds = userBooks.stream().map(Post::getBookId).collect(Collectors.toList());
        return bookService.getAllById(bookIds);
    }
}
