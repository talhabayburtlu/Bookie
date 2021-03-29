package com.swe.bookie.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.ISBN;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "book", schema = "public")
public class Book {

    @Id
    private String id;
    private String title;
    private String subtitle;
    private String author;
    @ISBN
    private String isbn;
    @Column(name = "image_small_thumbnail_link")
    private String imageSmallThumbnailLink;
    @Column(name = "image_thumbnail_link")
    private String imageThumbnailLink;
    private String description;

    @JsonIgnore
    @ManyToMany(mappedBy = "books")
    private List<User> users;

}
