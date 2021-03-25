package com.swe.bookie.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name = "Comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String description;

    @JsonIgnore()
    @ManyToOne()
    @JoinColumn(name = "sender_id", nullable = false)
    private User sender;

    @JsonIgnore()
    @ManyToOne()
    @JoinColumn(name = "receiver_id", nullable = false)
    private User receiver;


}
