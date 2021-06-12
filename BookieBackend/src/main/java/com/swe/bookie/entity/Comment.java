package com.swe.bookie.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@Table(name = "comment", schema = "public")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "description")
    private String description;

    @Column(name = "timestamp")
    private Timestamp timestamp;

    @JsonIgnore()
    @ManyToOne()
    @JoinColumn(name = "sender_id", nullable = false)
    private User sender;

    @ManyToOne()
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

}
