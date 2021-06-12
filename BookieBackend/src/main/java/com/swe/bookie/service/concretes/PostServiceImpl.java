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

import java.util.ArrayList;
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
    public Post getById(int id) {
        return postRepository.getById(id);
    }

    @Override
    public Post getByUserIdAndBookId(int userId, String bookId) {
        return postRepository.getByBookIdAndUserId(bookId, userId);
    }

    @Override
    public Post add(String bookId, User user) {
        Post userBookToAdd = new Post();
        userBookToAdd.setUserId(user.getId());
        userBookToAdd.setBookId(bookId);
        userBookToAdd.setStatus("Available");
        return postRepository.save(userBookToAdd);
    }

    @Override
    public Post delete(String bookId, User user) {
        Post post = postRepository.getByBookIdAndUserId(bookId, user.getId());
        return postRepository.deleteById(post.getId());
    }

    @Override
    public List<Book> getBooksByUserId(int userId) {
        List<Post> userPosts = postRepository.getAllByUserId(userId);
        List<String> bookIds = userPosts.stream().map(Post::getBookId).collect(Collectors.toList());

        List<Book> books = new ArrayList<>();

        for (String bookId : bookIds) {
            books.add(bookService.getById(bookId));

        }
        return books;
    }


    @Override
    public Comment toComment(User sender, int ownerId, String bookId, String description) {
        return commentService.add(sender, postRepository.getByBookIdAndUserId(bookId, ownerId), description);
    }

    @Override
    public List<Comment> getAllByPostId(int postId) {
        return commentService.getAllByPost(postRepository.getById(postId));
    }

    @Override
    public List<Comment> getCommentsByUserIdAndBookId(int userId, String bookId){
        Post post = postRepository.getByBookIdAndUserId(bookId,userId);
        return getAllByPostId(post.getId());
    }

    @Override
    public List<Post> getAllPostsByUserId(int userId) {
        return postRepository.getAllByUserId(userId);
    }

    @Override
    public Post updatePostStatus(int userId, String bookId, String status, User owner) {
        Post post = postRepository.getByBookIdAndUserId(bookId, userId);

        if (post.getUserId() != owner.getId())
            throw new RuntimeException("You are not owner of this post.");

        post.setStatus(status);
        return postRepository.save(post);
    }


}
