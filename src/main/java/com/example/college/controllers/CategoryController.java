package com.example.college.controllers;

import com.example.college.models.Category;
import com.example.college.services.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping("/category")
    public String categorys(@RequestParam(name = "title", required = false) String title, Model model) {
        model.addAttribute("category", categoryService.findAll(title));
        return "categorys";
    }

//    @GetMapping("/category/{id}")
//    public String categoryInfo(@PathVariable Long id, Model model) {
//        Category category = categoryService.findById(id);
//        model.addAttribute("match", category);
//        return "category-info";
//    }

//    @PostMapping("/category/create")
//    public String createCategory(@RequestParam("file1") MultipartFile file1, Category category) throws IOException {
//        categoryService.save(file1,category);
//        return "redirect:/category";
//
//    }

    @PostMapping("/category/delete/{id}")
    public String deleteCategory(@PathVariable Long id) {
        categoryService.deleteById(id);
        return "redirect:/category";
    }
}
