package com.example.college.controllers.admin;

import com.example.college.models.Product;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
import javassist.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/admin/products")
@RequiredArgsConstructor
public class AdminProductsController {

    private final ProductService productService;
    private final CategoryService categoryService;

    @PostMapping("/create")
    public String createProduct(@RequestParam("fileProduct1") MultipartFile fileProduct1,
                                @RequestParam("fileProduct2") MultipartFile fileProduct2,
                                @RequestParam("fileProduct3") MultipartFile fileProduct3,
                                Product product, Principal principal,
                                Model model, @RequestParam("dimension") List<String> dimensions,
                                @RequestParam("quantity") List<Integer> quantities,
                                HttpServletRequest request, HttpServletResponse response) throws IOException {
        productService.saveProduct(principal, product, fileProduct1, fileProduct2, fileProduct3, dimensions, quantities);
        return referer(request, response);
    }

    @PostMapping("/update/{id}")
    public String updateProduct(@PathVariable("id") Long id,
                                Product product,
                                @RequestParam("fileProduct1") MultipartFile fileProduct1,
                                @RequestParam("fileProduct2") MultipartFile fileProduct2,
                                @RequestParam("fileProduct3") MultipartFile fileProduct3,
                                @RequestParam("dimension") List<String> dimensions,
                                @RequestParam("quantity") List<Integer> quantities,@RequestParam(value = "isActive", required = false) boolean isActive,
                                HttpServletRequest request, HttpServletResponse response) throws IOException {
        product.setPopular(isActive);
        productService.updateProduct(id, product, fileProduct1, fileProduct2, fileProduct3, dimensions, quantities);
        return referer(request, response);
    }

    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
        boolean deleteMessage = productService.deleteProduct(id);
        if (deleteMessage) {
            redirectAttributes.addFlashAttribute("successMessage", "Категория удалена!");
        }
        return referer(request, response);
    }


    public String referer(HttpServletRequest request, javax.servlet.http.HttpServletResponse response) {
        String referer = "/admin/products";// Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
