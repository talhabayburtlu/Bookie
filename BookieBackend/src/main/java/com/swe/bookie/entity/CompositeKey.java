package com.swe.bookie.entity;

import javax.persistence.Id;
import java.io.Serializable;


public class CompositeKey implements Serializable {
    @Id
    private int userId;
    @Id
    private String bookId;

}
