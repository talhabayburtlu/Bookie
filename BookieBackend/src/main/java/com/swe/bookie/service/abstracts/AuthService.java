package com.swe.bookie.service.abstracts;

import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.dto.VerificationDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.UserResource;

public interface AuthService {
    User getAuthenticatedUser();

    LoginResource login(LoginDTO loginDTO);

    UserResource register(UserDTO userDTO);

    void verify(VerificationDTO verificationDTO) throws Exception;

}
