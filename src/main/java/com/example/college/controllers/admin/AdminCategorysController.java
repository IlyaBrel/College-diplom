package com.example.college.controllers.admin;

import com.example.college.models.Category;
import com.example.college.models.productProperties.Brand;
import com.example.college.models.productProperties.Color;
import com.example.college.services.CategoryService;
import com.example.college.services.product.properties.BrandService;
import com.example.college.services.product.properties.ColorService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/admin/categorys")
@RequiredArgsConstructor
public class AdminCategorysController {

    private final CategoryService categoryService;
    private final BrandService brandService;
    private final ColorService colorService;


    @PostMapping("/create")
    public String createCategory(@RequestParam("file1") MultipartFile file1, Category category,   HttpServletRequest request, HttpServletResponse response) throws IOException {
        categoryService.save(file1, category);
        return referer(request,response);
    }

    @PostMapping("/update/{categoryId}")
    public String updateCategory(@PathVariable("categoryId") Long id, @RequestParam("file") MultipartFile file,Category category, HttpServletRequest request, HttpServletResponse response) throws IOException {
        categoryService.update(id, file, category);
        return referer(request,response);
    }

    @PostMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
        boolean deleteMessage = categoryService.deleteById(id);
        if (deleteMessage) {
            redirectAttributes.addFlashAttribute("successMessage", "Категория удалена!");
        }
        return referer(request,response);
    }

    @PostMapping("/brand/create")
    public String createBrand(Brand brand,HttpServletRequest request, HttpServletResponse response)throws IOException{
        brandService.save(brand);
        return referer(request,response);
    }
    @PostMapping("/brand/update/{id}")
    public String updateBrand(@PathVariable("id")Long id, Brand brand,HttpServletRequest request, HttpServletResponse response) throws IOException {
       brandService.update(id,brand);
        return referer(request,response);
    }
    @PostMapping("/brand/delete/{id}")
    public String deleteBrand(@PathVariable("id")Long id, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
        boolean deleteMessage = brandService.deleteById(id);
        if (deleteMessage) {
            redirectAttributes.addFlashAttribute("successMessage", "Категория удалена!");
        }
        return referer(request,response);
    }


    @PostMapping("/color/create")
    public String createColor(Color color,HttpServletRequest request, HttpServletResponse response)throws IOException{
        colorService.save(color);
        return referer(request,response);
    }

    @PostMapping("/color/update/{id}")
    public String updateColor(@PathVariable("id")Long id, Color color, HttpServletRequest request, HttpServletResponse response ) throws IOException {
        colorService.update(id,color);
        return referer(request,response);
    }
    @PostMapping("/color/delete/{id}")
    public String deleteColor(@PathVariable("id")Long id,HttpServletRequest request, HttpServletResponse response,  RedirectAttributes redirectAttributes){
        boolean deleteMessage = colorService.deleteById(id);
        if (deleteMessage) {
            redirectAttributes.addFlashAttribute("successMessage", "Категория удалена!");
        }
        return referer(request,response);
    }


    public String referer(HttpServletRequest request, javax.servlet.http.HttpServletResponse response){
        String referer = "/admin/categorys";// Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
