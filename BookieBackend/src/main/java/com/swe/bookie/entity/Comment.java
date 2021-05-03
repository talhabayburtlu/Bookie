package com.swe.bookie.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;

@Data
@Entity
@Table(name = "comment", schema = "public")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String description;

    @JsonIgnore()
    @ManyToOne()
    @JoinColumn(name = "sender_id", nullable = false)
    private User sender;

    @ManyToOne()
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

}
