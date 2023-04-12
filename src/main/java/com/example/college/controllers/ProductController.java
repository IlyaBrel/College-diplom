package com.example.college.controllers;

import com.example.college.models.Product;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
import com.example.college.util.CartUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    private final CategoryService categoryService;
    private final CartUtil cartUtil;


    @GetMapping("/products")
    public String products(@RequestParam(name = "title", required = false) String title,
            @RequestParam(name = "city", required = false) String city,
            @RequestParam(name = "category", required = false) Long categoryId,
            Principal principal, Model model, HttpServletRequest request, HttpServletResponse response) {

        model.addAttribute("category", categoryService.findAll());
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));

        model.addAttribute("cart", cartUtil.getCart(request, response));
        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "product-info";
    }

}
