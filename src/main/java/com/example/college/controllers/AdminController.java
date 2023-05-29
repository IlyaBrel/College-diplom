package com.example.college.controllers;


import com.example.college.models.User;
import com.example.college.models.enums.Role;
import com.example.college.models.enums.Status;
import com.example.college.services.*;
import com.example.college.services.product.properties.BrandService;
import com.example.college.services.product.properties.ColorService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")

public class AdminController {

    private final UserService userService;
    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;
    private final ColorService colorService;

    private final OrderService orderService;

    private final NewsService newsService;

    //users
    @GetMapping("/admin")
    public String admin(@RequestParam(name = "title", required = false) String title, Model model) {
        model.addAttribute("users", userService.list());
        model.addAttribute("category", categoryService.findAll());
        model.addAttribute("products", productService.listProducts(title));
        return "admin";
    }

    //products
    @GetMapping("/admin/products")
    public String adminProducts(@RequestParam(name = "title", required = false) String title, Model model) {
        model.addAttribute("category", categoryService.findAll());
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("colors", colorService.findAll());
        return "admin-products";
    }
    //категории, бренды, цвета
    @GetMapping("/admin/categorys")
    public String adminCategorys(Model model) {
        model.addAttribute("category", categoryService.findAll());
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("colors", colorService.findAll());
        return "admin-category";
    }

    @GetMapping("/admin/orders")
    public String adminOrders(Model model) {
       model.addAttribute("orders", orderService.findAll());
        model.addAttribute("status", Status.values());
        model.addAttribute("productService", productService);
        return "admin-orders";
    }

    @GetMapping("/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @GetMapping("/admin/news")
    public String adminNews(Model model,@RequestParam(name = "title", required = false) String title){
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("news", newsService.findAll());
        return "admin-news";
    }


}
