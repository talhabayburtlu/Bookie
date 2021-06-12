package com.swe.bookie.mapper;

import com.swe.bookie.entity.Book;
import com.swe.bookie.lib.resource.PostBookResponse;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class PostBookMapper {
    private final ModelMapper modelMapper = new ModelMapper();

    public PostBookResponse toResource(Book book, String status) {
        PostBookResponse postBookResponse = modelMapper.map(book, PostBookResponse.class);
        postBookResponse.setStatus(status);
        return postBookResponse;
    }

}
