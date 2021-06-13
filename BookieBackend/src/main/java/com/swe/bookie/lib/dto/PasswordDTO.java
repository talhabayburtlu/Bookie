package com.swe.bookie.lib.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PasswordDTO {
    private String currentPass;
    private String newPass;

}
