package com.example.college.controllers;

import com.example.college.models.News;
import com.example.college.models.Product;
import com.example.college.services.NewsService;
import com.example.college.services.ProductService;
import com.example.college.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
@Controller
@RequiredArgsConstructor
public class NewsController {

    private final NewsService newsService;
    private final ProductService productService;

    @GetMapping("/news/{id}")
    public String newsInfo(@PathVariable Long id, Model model, Principal principal) {
        News news = newsService.findById(id);
        model.addAttribute("news", news);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("productService", productService);
        return "news-info";
    }

}
