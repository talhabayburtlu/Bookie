package com.swe.bookie.lib.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDTO {
    private short age;
    private String fullname;
    private String email;
    private String password;
    private String phone;
    private int addressId;
}
