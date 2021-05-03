package com.swe.bookie.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.validator.constraints.ISBN;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "book", schema = "public")
public class Book {

    @Id
    private String id;
    @Column(name = "title")
    private String title;
    @Column(name = "subtitle")
    private String subtitle;
    @Column(name = "author")
    private String author;
    @ISBN
    @Column(name = "isbn")
    private String isbn;
    @Column(name = "image_small_thumbnail_link")
    private String imageSmallThumbnailLink;
    @Column(name = "image_thumbnail_link")
    private String imageThumbnailLink;
    @Column(name = "description")
    private String description;

    @JsonIgnore
    @ManyToMany(mappedBy = "books")
    private List<User> users;

}
