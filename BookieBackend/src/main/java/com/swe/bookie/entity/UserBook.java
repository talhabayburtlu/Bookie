package com.swe.bookie.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@IdClass(CompositeKey.class)
@Table(name = "user_book")
public class UserBook {

    @Id
    @Column(name = "user_id")
    private int userId;
    @Id
    @Column(name = "book_id")
    private String bookId;
}
