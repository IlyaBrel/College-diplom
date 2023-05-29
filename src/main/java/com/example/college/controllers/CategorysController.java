package com.example.college.controllers;

import com.example.college.services.CategoryService;
import com.example.college.services.NewsService;
import com.example.college.services.ProductService;
import com.example.college.services.UserService;
import com.example.college.services.product.properties.BrandService;
import com.example.college.services.product.properties.ColorService;
import com.example.college.util.CartUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
@RequiredArgsConstructor
public class CategorysController {


    private final ProductService productService;
    private final CategoryService categoryService;
    private final CartUtil cartUtil;
    private final BrandService brandService;
    private final ColorService colorService;


    @GetMapping("/category")
    public String cegoryPage(Model model,  HttpServletRequest request, HttpServletResponse response, Principal principal) {
        model.addAttribute("categorys", categoryService.findAll());
        model.addAttribute("cart", cartUtil.getCart(request, response));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("cartInfo", cartUtil.totalPrice(request));

        model.addAttribute("brands", brandService.findAll());
        model.addAttribute("colors", colorService.findAll());
        return "category";
    }

}
