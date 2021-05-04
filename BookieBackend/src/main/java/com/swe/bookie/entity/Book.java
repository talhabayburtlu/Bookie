package com.swe.bookie.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.hibernate.validator.constraints.ISBN;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@AllArgsConstructor
@Data
@Entity
@Table(name = "book", schema = "public")
public class Book {

    @Id
    @Column(name = "id", unique = true, nullable = false)
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

    public Book() {
    }

}
