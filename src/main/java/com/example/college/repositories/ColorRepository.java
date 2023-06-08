package com.example.college.repositories;

import com.example.college.models.product.properties.Color;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ColorRepository extends JpaRepository<Color, Long> {
}
