package com.swe.bookie.lib.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private int ownerId;
    private String bookId;
    private String content;
}
