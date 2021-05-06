package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.UserRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.Comment;
import com.swe.bookie.entity.Post;
import com.swe.bookie.entity.User;
import com.swe.bookie.service.abstracts.CommentService;
import com.swe.bookie.service.abstracts.PostService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostService postService;

    @Autowired
    private CommentService commentService;


    @Override
    public User findById(int id) {
        return userRepository.findById(id).orElseThrow(RuntimeException::new);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElseThrow(RuntimeException::new);
    }

    @Override
    public User getByEmail(String email) {
        return userRepository.getByEmail(email);
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


    @Override
    public Comment toComment(int userId, int postId, String description) {
        return postService.toComment(userRepository.getById(userId), postId, description);
    }

    @Override
    public Comment deleteComment(int userId, int commentId) {
        return commentService.delete(userRepository.getById(userId), commentId);
    }

    @Override
    public List<Post> getPostByUserId(int userId){
        return postService.getAllPostsByUserId(userId);
    }

    @Override
    public List<Book> getLibraryByUserId(int userId) {
        return postService.getBooksByUserId(userId);

    }
}
