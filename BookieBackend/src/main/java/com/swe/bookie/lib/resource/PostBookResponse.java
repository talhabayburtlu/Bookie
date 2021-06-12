package com.swe.bookie.lib.resource;

import lombok.Data;

@Data
public class PostBookResponse {
    private String id;
    private String title;
    private String subtitle;
    private String author;
    private String isbn;
    private String imageSmallThumbnailLink;
    private String imageThumbnailLink;
    private String description;
    private String status;
}
