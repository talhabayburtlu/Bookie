package com.swe.bookie.controller;

import com.swe.bookie.entity.Token;
import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.LoginDTO;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.dto.VerificationDTO;
import com.swe.bookie.lib.resource.LoginResource;
import com.swe.bookie.lib.resource.RegisterResource;
import com.swe.bookie.lib.resource.UserResource;
import com.swe.bookie.lib.resource.VerificationResource;
import com.swe.bookie.service.abstracts.AuthService;
import com.swe.bookie.service.abstracts.TokenService;
import com.swe.bookie.service.abstracts.UserService;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    private final JavaMailSender javaMailSender;

    private final TokenService tokenService;

    private final UserService userService;

    @Autowired
    public AuthController(AuthService authService,
                          @Qualifier("getJavaMailSender") JavaMailSender javaMailSender,
                          TokenService tokenService,
                          UserService userService) {
        this.authService = authService;
        this.javaMailSender = javaMailSender;
        this.tokenService = tokenService;
        this.userService = userService;
    }

    @PostMapping("/login")
    public LoginResource login(@RequestBody LoginDTO loginDTO) {
        return this.authService.login(loginDTO);
    }

    @PostMapping("/register")
    public RegisterResource register(@RequestBody UserDTO userDTO) {
        UserResource userResource = null;
        LoginResource loginResource = null;
        String message = "Verification sent to " + userDTO.getEmail() + " .";
        try {
            userResource = this.authService.register(userDTO);
            loginResource = this.authService.login(new LoginDTO(userDTO.getEmail(), userDTO.getPassword()));

            User user = userService.findByEmail(userDTO.getEmail());

            Token token = new Token(RandomString.make(6), user);
            tokenService.save(token);

            SimpleMailMessage mailMessage = new SimpleMailMessage();
            mailMessage.setFrom("bookie.application2@gmail.com");
            mailMessage.setTo(userDTO.getEmail());
            mailMessage.setSubject("Bookie Application - Verification");
            mailMessage.setText("Verification token is: " + token.getToken() + " .");
            javaMailSender.send(mailMessage);

        } catch (Exception e) {
            if (e.getLocalizedMessage().contains("uq_user_mail"))
                message = "This email is used by another user.";
            else if (e.getLocalizedMessage().contains("uq_phone"))
                message = "This phone number is used by another user.";
            else
                message = "Unexpected error occurred.";
        }

        return new RegisterResource(userResource, loginResource, message);
    }

    @PostMapping("/verify")
    public VerificationResource verify(@RequestBody VerificationDTO verificationDTO) {
        try {
            authService.verify(verificationDTO);
            return new VerificationResource(true, "Successfully verified.");
        } catch (Exception e) {
            if (e.getMessage() == null)
                return new VerificationResource(false, "The user is not found with given email.");
            else
                return new VerificationResource(false, e.getMessage());
        }
    }

}
