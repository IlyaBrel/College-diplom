package com.example.college.services;

import com.example.college.models.Category;
import com.example.college.models.Image;
import com.example.college.models.Product;
import com.example.college.repositories.CategoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;


    public Category findById(Long id) {
        return categoryRepository.findById(id).orElse(null);
    }

    public Page<Category> findFirst6Employees() {
        return categoryRepository.findAll(PageRequest.of(0, 6));
    }

    public List<Category> findAll(String title) {
        return categoryRepository.findAll();
    }


    public void save(MultipartFile file, Category category) throws IOException {
        Image image1;
        if (file.getSize() != 0) {
            image1 = toImageEntityC(file);
           image1.setPreviewImage(true);
            category.addImageToCategory(image1);
        }

//        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Category categoryFromDb = categoryRepository.save(category);
        categoryFromDb.setPreviewImageId(categoryFromDb.getImageC().get(0).getId());
        categoryRepository.save(category);
    }


    public void deleteById(Long id) {
        categoryRepository.deleteById(id);
    }

    private Image toImageEntityC(MultipartFile file) throws IOException {
        Image image1 = new Image();
        image1.setName(file.getName());
        image1.setOriginalFileName(file.getOriginalFilename());
        image1.setContentType(file.getContentType());
        image1.setSize(file.getSize());
        image1.setBytes(file.getBytes());
        return image1;
    }

}
