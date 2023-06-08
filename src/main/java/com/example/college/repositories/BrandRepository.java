package com.example.college.repositories;

import com.example.college.models.product.properties.Brand;
import org.springframework.data.jpa.repository.JpaRepository;


public interface BrandRepository extends JpaRepository<Brand, Long> {
}
