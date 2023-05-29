package com.example.college.controllers;

import com.example.college.models.Product;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
import com.example.college.services.UserService;
import com.example.college.services.product.properties.BrandService;
import com.example.college.services.product.properties.ColorService;
import com.example.college.util.CartUtil;
import com.example.college.util.FilterUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;
    private final ColorService colorService;
    private final FilterUtil filterUtil;
    private final CartUtil cartUtil;


    @GetMapping("/products")
    public String products(@RequestParam(name = "title", required = false) String title,
                           Principal principal, Model model, HttpServletRequest request, HttpServletResponse response) {
        model.addAttribute("colors", colorService.findAll());
        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("category", categoryService.findAll());

        model.addAttribute("cart", cartUtil.getCart(request, response));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("cartInfo", cartUtil.totalPrice(request));
        model.addAttribute("selectedFilterParam", filterUtil.getAllFinder(request, response));
        model.addAttribute("allSizes", productService.getAllSizes());
        if (filterUtil.getFilter(request, response).getMinPrice() != null) {
            model.addAttribute("minPrice", filterUtil.getFilter(request, response).getMinPrice());
        } else {
            model.addAttribute("minPrice", String.valueOf(productService.getMinPriceProduct()));
        }
        if (filterUtil.getFilter(request, response).getMaxPrice() != null) {
            model.addAttribute("maxPrice", filterUtil.getFilter(request, response).getMaxPrice());
        } else {
            model.addAttribute("maxPrice", String.valueOf(productService.getMaxPriceProduct()));
        }

        if (title == null || title.isEmpty()) {
            model.addAttribute("products", productService.selectedFilters(request, response));
        } else {
            model.addAttribute("products", productService.listProducts(title));
        }

        return "/products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("cart", cartUtil.getCart(request, response));
        model.addAttribute("cartInfo", cartUtil.totalPrice(request));
        return "product-info";
    }



}
