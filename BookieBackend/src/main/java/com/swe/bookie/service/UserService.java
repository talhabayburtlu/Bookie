package com.swe.bookie.service;

import com.swe.bookie.entity.User;

public interface UserService {
    User findById(int id);

    User findByEmail(String email);

    void save(User user);
}
