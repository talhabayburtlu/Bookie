package com.swe.bookie.service.abstracts;

import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.UserResource;

public interface AuthService {
    LoginResource login(LoginDTO loginDTO);

    UserResource register(UserDTO userDTO);
}
