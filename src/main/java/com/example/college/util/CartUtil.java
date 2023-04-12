package com.example.college.util;

import com.example.college.models.Cart;
import com.example.college.models.Product;
import com.example.college.services.ProductService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

@Component
@Slf4j
@RequiredArgsConstructor
public class CartUtil {

    private static final String CART_COOKIE_NAME = "cart";
    private static final ObjectMapper objectMapper = new ObjectMapper();
    private final ProductService productService;
    Cart cartToProduct = new Cart();

    public List<Cart> getCart(HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = getCartFromCookie(request);
        saveCartToCookie(response, cart);
        return cart;
    }

    public void addToCart(@PathVariable Long id,String size,HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = getCartFromCookie(request);
        Product product = productService.getProductById(id);
        cartToProduct.setPreviewImage(product.getPreviewImageId());
        cartToProduct.setTitle(product.getTitle());
        cartToProduct.setDescription(product.getDescription());
        cartToProduct.setPrice(product.getPrice());
        cartToProduct.setSize(size);
        cartToProduct.setPromotionalPrice(product.getPromotionalPrice());
        cart.add(cartToProduct);
        saveCartToCookie(response, cart);
    }

    public List<Cart> removeFromCart(@PathVariable("index") int index, HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = getCartFromCookie(request);
        cart.remove(index);
        saveCartToCookie(response, cart);
        return cart;
    }

    private List<Cart> getCartFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        List<Cart> cart = new ArrayList<>();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (CART_COOKIE_NAME.equals(cookie.getName())) {
                    try {
                        cart = objectMapper.readValue(URLDecoder.decode(cookie.getValue(), "UTF-8"), new TypeReference<List<Cart>>() {
                        });
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
