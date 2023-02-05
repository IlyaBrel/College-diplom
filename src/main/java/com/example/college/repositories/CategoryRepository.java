package com.example.college.repositories;

import com.example.college.models.Category;
import com.example.college.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Long> {


}
