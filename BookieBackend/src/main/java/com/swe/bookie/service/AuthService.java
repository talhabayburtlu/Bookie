package com.swe.bookie.service;

import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.RegisterDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.RegisterResource;

public interface AuthService {
    LoginResource login(LoginDTO loginDTO);

    RegisterResource register(RegisterDTO registerDTO);
}
