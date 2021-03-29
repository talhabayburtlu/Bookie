package com.swe.bookie.service;

import com.swe.bookie.config.security.JwtUtil;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.RegisterDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.RegisterResource;
import com.swe.bookie.mapper.RegisterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;
    private final JwtUtil jwtTokenUtil;
    private final PasswordEncoder bcryptEncoder;
    private final UserService userService;
    private final RegisterMapper registerMapper;

    @Autowired
    public AuthServiceImpl(AuthenticationManager authenticationManager,
                           @Qualifier("userDetailsServiceImpl") UserDetailsService userDetailsService,
                           JwtUtil jwtTokenUtil,
                           PasswordEncoder bcryptEncoder,
                           UserService userService,
                           RegisterMapper registerMapper) {
        this.authenticationManager = authenticationManager;
        this.userDetailsService = userDetailsService;
        this.jwtTokenUtil = jwtTokenUtil;
        this.bcryptEncoder = bcryptEncoder;
        this.userService = userService;
        this.registerMapper = registerMapper;
    }

    @Override
    public LoginResource login(LoginDTO loginDTO) {
        try {
            // Trying to authenticate with mail and password.
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginDTO.getEmail(), loginDTO.getPassword()));
        } catch (BadCredentialsException e) {
            throw new BadCredentialsException("Incorrect email and password.");
        }

        final UserDetails userDetails = userDetailsService.loadUserByUsername(loginDTO.getEmail()); // Loading user details.
        final String jwt = jwtTokenUtil.generateToken(userDetails); // Generating jwt token in order to send it back.

        return new LoginResource(jwt);
    }

    @Override
    public RegisterResource register(RegisterDTO registerDTO) {
        System.out.println(registerDTO);
        User user = registerMapper.toEntity(registerDTO);
        user.setPassword(bcryptEncoder.encode(user.getPassword())); // Setting password by encoding it.
        userService.save(user);

        return registerMapper.toResource(user);
    }


}
