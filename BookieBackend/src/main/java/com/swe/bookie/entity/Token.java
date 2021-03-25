package com.swe.bookie.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Token")
public class Token {
    @Id
    private String token;

    @ManyToOne()
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

}
