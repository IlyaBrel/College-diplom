package com.example.college.controllers;

import com.example.college.models.Cart;
import com.example.college.models.Product;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
import com.example.college.util.CartUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class HomePageController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final CartUtil cartUtil;
    private static final String CART_COOKIE_NAME = "cart";
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/")
    public String homePage(@RequestParam(name = "title", required = false) String title, Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {
        model.addAttribute("categorys", categoryService.findAll(title));
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("cart", cartUtil.getCart(request,response));
        return "home";
    }


}