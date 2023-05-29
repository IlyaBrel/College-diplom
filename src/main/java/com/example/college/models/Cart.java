package com.example.college.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    private Long productId;
    private Long previewImage;
    private String title;
    private String description;
    private Map<Long, String> idAndSize = new HashMap<>();
    private String size;
    private int price;
    private int promotionalPrice;
}