package com.swe.bookie.lib.resource;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegisterResource {
    private int id;
    private short age;
    private String fullname;
    private String email;
    private String phone;
    private String city;
}
