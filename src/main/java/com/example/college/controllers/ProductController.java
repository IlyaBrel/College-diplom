package com.example.college.controllers;

import com.example.college.models.Category;
import com.example.college.models.Product;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;

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
import java.util.Arrays;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    private final CategoryService categoryService;


    @GetMapping("/products")
    public String products(@RequestParam(name = "title", required = false) String title, Principal principal, Model model) {
        model.addAttribute("category", categoryService.findAll(title));
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("product-size", product.getDimensions());
        model.addAttribute("images", product.getImages());
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("fileProduct1") MultipartFile fileProduct1, @RequestParam("fileProduct2") MultipartFile fileProduct2,
                                @RequestParam("fileProduct3") MultipartFile fileProduct3, Product product, Principal principal,
                                Model model,@RequestParam("dimensions") String dimensions)throws IOException {
        product.setDimension(dimensions);
        productService.saveProduct(principal, product, fileProduct1, fileProduct2, fileProduct3,dimensions);
        return "redirect:/products";
    }

    @PostMapping("/product/category/create")
    public String createCategory(@RequestParam("file1") MultipartFile file1, Category category) throws IOException {
        categoryService.save(file1,category);
        return "redirect:/products";

    }



    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }
}
