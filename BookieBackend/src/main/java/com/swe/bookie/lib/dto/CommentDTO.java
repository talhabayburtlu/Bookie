package com.swe.bookie.lib.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private int postId;
    private String content;
}
