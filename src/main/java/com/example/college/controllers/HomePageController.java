package com.example.college.controllers;

import com.example.college.models.Category;
import com.example.college.services.CategoryService;

import com.example.college.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class HomePageController {


    private final ProductService productService;
    private final CategoryService categoryService;

    @GetMapping("/")
    public String homePage(@RequestParam(name = "title", required = false) String title,Model model,Principal principal) {
        Page<Category> categorys = categoryService.findFirst6Employees();
        model.addAttribute("categorys", categoryService.findAll(title));
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "home";
    }

}
