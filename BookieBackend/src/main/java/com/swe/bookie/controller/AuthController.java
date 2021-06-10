package com.swe.bookie.controller;

import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.RegisterResource;
import com.swe.bookie.lib.resource.UserResource;
import com.swe.bookie.service.abstracts.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;


    @Autowired
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public LoginResource login(@RequestBody LoginDTO loginDTO) {
        return this.authService.login(loginDTO);
    }

    @PostMapping("/register")
    public RegisterResource register(@RequestBody UserDTO userDTO) {
        UserResource userResource = null;
        LoginResource loginResource = null;
        String message = "Kayıt olundu.";
        try {
            userResource = this.authService.register(userDTO);
            loginResource = this.authService.login(new LoginDTO(userDTO.getEmail(), userDTO.getPassword()));
        } catch (Exception e) {
            if (e.getLocalizedMessage().contains("uq_user_mail"))
                message = "Bu email başka bir kullanıcı tarafından kullanılıyor.";
            else if (e.getLocalizedMessage().contains("uq_phone"))
                message = "Bu telefon başka bir kullanıcı tarafından kullanılıyor.";
            else
                message = "Beklenmedik bir hata oluştu.";
        }
        return new RegisterResource(userResource, loginResource, message);
    }

}
