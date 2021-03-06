package com.swe.bookie.service.concretes;

import com.swe.bookie.config.security.JwtUtil;
import com.swe.bookie.entity.Token;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.dto.VerificationDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.UserResource;
import com.swe.bookie.mapper.UserMapper;
import com.swe.bookie.service.abstracts.AuthService;
import com.swe.bookie.service.abstracts.TokenService;
import com.swe.bookie.service.abstracts.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
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
    private final UserMapper userMapper;
    private final TokenService tokenService;


    @Autowired
    public AuthServiceImpl(AuthenticationManager authenticationManager,
                           @Qualifier("userDetailsServiceImpl") UserDetailsService userDetailsService,
                           JwtUtil jwtTokenUtil,
                           PasswordEncoder bcryptEncoder,
                           UserService userService,
                           UserMapper userMapper,
                           TokenService tokenService) {
        this.authenticationManager = authenticationManager;
        this.userDetailsService = userDetailsService;
        this.jwtTokenUtil = jwtTokenUtil;
        this.bcryptEncoder = bcryptEncoder;
        this.userService = userService;
        this.userMapper = userMapper;
        this.tokenService = tokenService;
    }

    @Override
    public User getAuthenticatedUser() {
        org.springframework.security.core.userdetails.User securityUser = // Getting authenticated user details.
                (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userService.findByEmail(securityUser.getUsername()); // Getting authenticated user by using user details.
    }

    @Override
    public LoginResource login(LoginDTO loginDTO) {
        try {
            // Trying to authenticate with mail and password.
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginDTO.getEmail(), loginDTO.getPassword()));

            User user = userService.findByEmail(loginDTO.getEmail());

            if (!user.getVerified())
                throw new Exception("Verification step required.");

        } catch (Exception ex) {
            if (ex.getMessage().contains("Verification"))
                return new LoginResource(null, ex.getMessage());
            else
                return new LoginResource(null, "User email or password is incorrect.");
        }

        final UserDetails userDetails = userDetailsService.loadUserByUsername(loginDTO.getEmail()); // Loading user details.
        final String jwt = jwtTokenUtil.generateToken(userDetails); // Generating jwt token in order to send it back.
        return new LoginResource(jwt, "Login established.");
    }

    @Override
    public UserResource register(UserDTO userDTO) {
        User user = userMapper.toEntity(userDTO);
        user.setPassword(bcryptEncoder.encode(user.getPassword())); // Setting password by encoding it.
        user.setVerified(false);

        userService.save(user);

        return userMapper.toResource(user);
    }

    @Override
    public void verify(VerificationDTO verificationDTO) throws Exception {
        User user = userService.findByEmail(verificationDTO.getEmail());

        if (user.getVerified())
            throw new Exception("This account is already verified.");

        Token token = tokenService.getByUserId(user.getId());

        if (!verificationDTO.getToken().equals(token.getToken()))
            throw new Exception("Token doesn't match.");

        user.setVerified(true);
        tokenService.deleteById(token.getId());

        userService.save(user);
    }


}
