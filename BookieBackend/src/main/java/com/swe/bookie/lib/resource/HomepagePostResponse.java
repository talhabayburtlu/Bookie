package com.swe.bookie.lib.resource;

import lombok.Data;

import java.util.List;

@Data
public class HomepagePostResponse {
   private RestrictedUserResource restrictedUserResource;
   private List<PostBookResponse> books;
}
