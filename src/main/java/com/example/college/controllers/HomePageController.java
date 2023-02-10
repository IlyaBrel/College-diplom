package com.example.college.controllers;

import com.example.college.models.Cart;
import com.example.college.models.Product;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
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

    private static final String CART_COOKIE_NAME = "cart";
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/")
    public String homePage(@RequestParam(name = "title", required = false) String title, Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = getCartFromCookie(request);
        int totalPrice = 0;

        for (Cart cartList : cart) {
            totalPrice += cartList.getPrice();
        }
        model.addAttribute("categorys", categoryService.findAll(title));
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("cart", cart);
        model.addAttribute("totalPrice",totalPrice );
        saveCartToCookie(response, cart);
        return "home";
    }

    @PostMapping("/cart/{id}")
    public String addToCart(@PathVariable Long id, HttpServletRequest request, HttpServletResponse response) {

        List<Cart> cart = getCartFromCookie(request);
        Product product = productService.getProductById(id);
        Cart cartToProduct = new Cart();
        cartToProduct.setPreviewImage(product.getPreviewImageId());
        cartToProduct.setTitle(product.getTitle());
        cartToProduct.setDescription(product.getDescription());
        cartToProduct.setPrice(product.getPrice());
        cartToProduct.setPromotionalPrice(product.getPromotionalPrice());
        cart.add(cartToProduct);

        saveCartToCookie(response, cart);
        return "redirect:/";
    }

    @PostMapping("/cart/remove/{index}")
    public String removeFromCart(@PathVariable("index") int index, HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = getCartFromCookie(request);
        cart.remove(index);

        saveCartToCookie(response, cart);

        return "redirect:/";
    }

    private List<Cart> getCartFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        List<Cart> cart = new ArrayList<>();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (CART_COOKIE_NAME.equals(cookie.getName())) {
                    try {
                        cart = objectMapper.readValue(URLDecoder.decode(cookie.getValue(), "UTF-8"), new TypeReference<List<Cart>>(){});
                    } catch (IOException e) {
                        log.error("Failed to read cart from cookie", e);
                    }
                }
            }
        }

        return cart;
    }

    private void saveCartToCookie(HttpServletResponse response, List<Cart> cart) {
        try {
            Cookie cookie = new Cookie(CART_COOKIE_NAME, URLEncoder.encode(objectMapper.writeValueAsString(cart), "UTF-8"));
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (JsonProcessingException e) {
            log.error("Failed to write cart to cookie", e);
        } catch (UnsupportedEncodingException e) {
            log.error("Failed to encode cart value", e);
        }
    }


}