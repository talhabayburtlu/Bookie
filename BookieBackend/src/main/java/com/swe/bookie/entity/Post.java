package com.swe.bookie.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "post", schema = "public")
public class Post {
    @Id
    @Column(name = "post_id")
    private String id;
    private String status;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "book_id")
    private String bookId;
}
