package com.example.college.controllers;


import com.example.college.services.ProductService;
import com.example.college.util.CartUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartUtil cartUtil;


    @PostMapping("/add/{id}")
    public String addToCart(@PathVariable Long id, HttpServletRequest request, HttpServletResponse response){
        cartUtil.addToCart(id,request,response);
        return referer(request,response);

    }

    @PostMapping("/delete/{index}")
    public String deleteCartItem(@PathVariable("index") int index, HttpServletRequest request, HttpServletResponse response) {
        cartUtil.removeFromCart(index,request,response);
        return referer(request,response);
    }

    public String referer(HttpServletRequest request,HttpServletResponse response){
        String referer = request.getHeader("Referer"); // Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}