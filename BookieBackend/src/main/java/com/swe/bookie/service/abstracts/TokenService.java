package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.Token;

public interface TokenService {
    Token getByUserId(int userId) throws Exception;

    void save(Token token);

    void deleteById(int id);
}
