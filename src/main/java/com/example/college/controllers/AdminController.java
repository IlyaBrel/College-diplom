package com.example.college.controllers;


import com.example.college.models.Category;
import com.example.college.models.Product;
import com.example.college.models.User;
import com.example.college.models.enums.Role;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
import com.example.college.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {

    private final UserService userService;
    private final ProductService productService;
    private final CategoryService categoryService;

    @GetMapping("/admin")
    public String admin(@RequestParam(name = "title", required = false) String title, Model model) {
        model.addAttribute("users", userService.list());
        model.addAttribute("category", categoryService.findAll(title));
        model.addAttribute("products", productService.listProducts(title));
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.changeUserRoles(user, form);
        return "redirect:/admin";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("fileProduct1") MultipartFile fileProduct1, @RequestParam("fileProduct2") MultipartFile fileProduct2,
                                @RequestParam("fileProduct3") MultipartFile fileProduct3, Product product, Principal principal,
                                Model model, @RequestParam("dimensions") String dimensions) throws IOException {
        product.setDimension(dimensions);
        productService.saveProduct(principal, product, fileProduct1, fileProduct2, fileProduct3, dimensions);
        return "redirect:/products";
    }

    @PostMapping("/product/category/create")
    public String createCategory(@RequestParam("file1") MultipartFile file1, Category category) throws IOException {
        categoryService.save(file1, category);
        return "redirect:/products";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }
}
