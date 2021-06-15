package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.TokenRepository;
import com.swe.bookie.entity.Token;
import com.swe.bookie.service.abstracts.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TokenServiceImpl implements TokenService {

    @Autowired
    private TokenRepository tokenRepository;

    @Override
    public Token getByUserId(int userId) throws Exception {
        Token token = tokenRepository.findByUserId(userId).orElse(null);

        if (token == null) {
            throw new Exception("This user doesn't have a token.");
        }

        return token;

    }

    @Override
    public void save(Token token) {
        tokenRepository.save(token);
    }

    public void deleteById(int id) {
        tokenRepository.deleteById(id);
    }
}
