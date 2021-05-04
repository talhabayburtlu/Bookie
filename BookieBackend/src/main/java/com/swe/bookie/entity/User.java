package com.swe.bookie.entity;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.util.List;

@Data
@Entity
@Table(name = "user", schema = "public")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private short age;
    private String fullname;
    @Email
    private String email;
    private String password;
    private String phone;

    @ManyToOne
    @JoinColumn(name = "address_id", nullable = false)
    private Address address;

    @OneToMany(mappedBy = "sender")
    private List<Comment> sentComments;

    @OneToMany(mappedBy = "userId")
    private List<Post> posts;
}
