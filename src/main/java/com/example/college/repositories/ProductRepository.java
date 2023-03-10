package com.example.college.repositories;


import com.example.college.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByTitle(String title);

    List<Product> findByTitleContainingAndCityContainingAndCategoryId(String title, String city, Long categoryId);
    List<Product> findByTitleContainingOrCityContainingOrCategoryId(String title, String city, Long categoryId);

}
