package com.swe.bookie.lib.resource;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RestrictedUserResource {
    private int id;
    private String fullname;
    private String phone;
    private String city;
}
