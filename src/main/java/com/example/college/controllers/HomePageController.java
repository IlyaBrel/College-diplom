package com.example.college.controllers;

import com.example.college.models.User;
import com.example.college.services.CategoryService;
import com.example.college.services.NewsService;
import com.example.college.services.ProductService;
import com.example.college.services.UserService;
import com.example.college.util.CartUtil;
import com.example.college.util.JavaMailSenderUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/")
public class HomePageController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final CartUtil cartUtil;
    private final NewsService newsService;

    private final UserService userService;

    private final JavaMailSenderUtil javaMailSenderUtil;

    @GetMapping("/")
    public String homePage(@RequestParam(name = "title", required = false) String title, Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {
        model.addAttribute("categorys", categoryService.findAll());
        model.addAttribute("products", productService.listProducts(title));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("cart", cartUtil.getCart(request, response));
        model.addAttribute("news", newsService.findAll());
        model.addAttribute("productService", productService);
        model.addAttribute("cartInfo", cartUtil.totalPrice(request));
        return "home";
    }

    @GetMapping("/faq")
    public String faqPage(Model model, Principal principal) {
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "faq";
    }

    @GetMapping("/contact")
    public String contactPage(Model model, Principal principal) {
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "contact";
    }

    @PostMapping("/contact/message/{id}")
    public String messageToEmail(@PathVariable("id") Long id, @RequestParam(name = "name") String name, @RequestParam("message") String message) {
        User user = userService.getById(id);
        javaMailSenderUtil.contactFormMessage(user.getEmail(), "Обращение к администрации BELLSELL.", name, message);
        javaMailSenderUtil.contactFormMessageAdmin(user.getEmail(), user.getId(), name, message);
        return "redirect:/contact";
    }


}