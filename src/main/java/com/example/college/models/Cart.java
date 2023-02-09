package com.example.college.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    private Long previewImage;
    private String title;
    private String description;
    private int price;
    private int promotionalPrice;
}