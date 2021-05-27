package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.AddressRepository;
import com.swe.bookie.dao.UserRepository;
import com.swe.bookie.entity.*;
import com.swe.bookie.lib.resource.HomepagePostResponse;
import com.swe.bookie.lib.resource.RestrictedUserResource;
import com.swe.bookie.mapper.UserMapper;
import com.swe.bookie.service.abstracts.CommentService;
import com.swe.bookie.service.abstracts.PostService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class UserServiceImpl implements UserService {


    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AddressRepository addressRepository;

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
    public Post addBookToUser(String bookId, User user) {
        Post existPost = user.getPosts().stream().filter(post ->
                post.getBookId().equals(bookId)
        ).findFirst().orElse(null);

        if (existPost != null) { // If book already added to user's library, then return the post has been created.
            return existPost;
        }

        return postService.add(bookId, user); // If not return newly created post.
    }

    @Override
    public Post removeBookFromUser(String bookId, User user) {
        Post existPost = user.getPosts().stream().filter(post -> post.getBookId().equals(bookId)).findFirst().orElse(null);

        if (existPost == null)
            throw new RuntimeException("The book is not owned by this user.");

        return postService.delete(bookId, user);
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
    public List<Post> getPostByUserId(int userId) {
        return postService.getAllPostsByUserId(userId);
    }

    @Override
    public List<Book> getLibraryByUserId(int userId) {
        return postService.getBooksByUserId(userId);

    }

    @Override
    public List<User> getUsersByAddress(Address address) {
        return userRepository.getByAddress(address);
    }

    @Override
    public List<HomepagePostResponse> getHomepagePostsByUserId(int userId) {
        List<User> users = getUsersByAddress(userRepository.getById(userId).getAddress());

        List<HomepagePostResponse> homepagePostResponses = new ArrayList<>();
        for (User user : users) {
            if (user.getId() == userId)
                continue;

            List<Book> booksOfCurrentUser = getUserBooksByUserId(userId);

            if (booksOfCurrentUser.size() == 0)
                continue;

            HomepagePostResponse homepagePostResponse = new HomepagePostResponse();
            homepagePostResponse.setBooks(booksOfCurrentUser);

            RestrictedUserResource restrictedUserResource = userMapper.toRestrictedResource(user);

            homepagePostResponse.setRestrictedUserResource(restrictedUserResource);
            homepagePostResponses.add(homepagePostResponse);

        }
        return homepagePostResponses;
    }
}
