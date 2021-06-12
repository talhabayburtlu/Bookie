package com.swe.bookie.lib.resource;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class CommentResponse {
    private int id;
    private String description;
    private Timestamp timestamp;
    private int senderId;
    private String senderName;
    private int postId;
}
