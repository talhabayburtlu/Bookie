package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.*;
import com.swe.bookie.lib.dto.PasswordDTO;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.resource.HomepagePostResponse;

import java.util.List;

public interface UserService {
    User findById(int id);

    User findByEmail(String email);

    void save(User user);

    Post addBookToUser(String bookId, User user);

    Post removeBookFromUser(String bookId, User user);

    HomepagePostResponse getUserPostBookResponsesByUserId(int userId);

    List<Book> getUserBooksByUserId(int userId);

    Comment toComment(int userId, int ownerId, String bookId, String description);

    User getByEmail(String email);

    Comment deleteComment(int userId, int commentId);

    List<Book> getLibraryByUserId(int userId);

    List<Post> getPostByUserId(int userId);

    User updateUserDetails(UserDTO userDTO, User user);

    List<HomepagePostResponse> getHomepagePostsByUserId(int userId);

    List<User> getUsersByAddress(Address address);

    User changePass(PasswordDTO passwordDTO, int userId);
}
