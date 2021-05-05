package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.PostRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
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

    @Autowired
    private CommentServiceImpl commentService;

    @Override
    public Post getById(String id) {
        return postRepository.getById(id);
    }

    @Override
    public Post add(String bookId, int userId) {
        Post userBookToAdd = new Post();
        userBookToAdd.setUserId(userId);
        userBookToAdd.setBookId(bookId);
        userBookToAdd.setStatus("Available");
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


    @Override
    public Comment toComment(User sender, String postId, String description){
       return commentService.add(sender, postRepository.getById(postId), description);
    }

    @Override
    public List<Comment> getAllByPostId(String postId){
        return commentService.getAllByPost(postRepository.getById(postId));
    }
}
