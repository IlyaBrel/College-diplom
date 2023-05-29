package com.example.college.controllers.admin;

import com.example.college.models.Category;
import com.example.college.models.News;
import com.example.college.models.Product;
import com.example.college.services.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/admin/news")
@RequiredArgsConstructor
public class AdminNewsController {
    private final NewsService newsService;

    @PostMapping("/create")
    public String createNews(@RequestParam("file") MultipartFile file,
                             @RequestParam(value = "productsId", required = false) List<Long> productIds,
                             News news,
                             HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (productIds != null) {
            news.setProductsId(productIds);
        }
        newsService.save(file, news);
        return referer(request, response);
    }

    @PostMapping("/update/{newsId}")
    public String updateCategory(@PathVariable("newsId") Long id, @RequestParam("file") MultipartFile file, News news,  @RequestParam(value = "productsId", required = false) List<Long> productIds,HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (productIds !=null){
            news.setProductsId(productIds);
        }
        newsService.update(id, news, file);
        return referer(request, response);
    }

    @PostMapping("/delete/{id}")
    public String deleteNews(@PathVariable Long id, HttpServletRequest request, HttpServletResponse response) {
        newsService.deleteById(id);
        return referer(request, response);
    }

    public String referer(HttpServletRequest request, javax.servlet.http.HttpServletResponse response) {
        String referer = "/admin/news";// Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
