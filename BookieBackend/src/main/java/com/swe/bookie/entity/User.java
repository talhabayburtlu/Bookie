package com.swe.bookie.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "User")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private short age;
    private String fullname;
    @Email
    private String email;
    private String password;

    @ManyToOne
    @JoinColumn(name = "address_id", nullable = false)
    private Address address;

    @OneToMany(mappedBy = "sender")
    private List<Comment> sentComments;

    @OneToMany(mappedBy = "receiver")
    private List<Comment> receivedComments;

    @JsonIgnore()
    @OneToMany(mappedBy = "user")
    private List<Token> tokens;

    @ManyToMany()
    @JoinTable(
            name = "User_Book",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "book_id")
    )
    private List<Book> books;


}
