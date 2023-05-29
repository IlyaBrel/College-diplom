package com.example.college.services;

import com.example.college.models.Category;
import com.example.college.models.Image;
import com.example.college.models.News;
import com.example.college.models.Product;
import com.example.college.models.productProperties.Brand;
import com.example.college.repositories.ImageRepository;
import com.example.college.repositories.NewsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class NewsService {

    private final NewsRepository newsRepository;

    private final ImageRepository imageRepository;
    public News findById(Long id) {
        return newsRepository.findById(id).orElse(null);
    }

    public List<News> findAll() {
        return newsRepository.findAll();
    }

    public void save(MultipartFile file, News news) throws IOException {
        Image image1;
        if (file.getSize() != 0) {
            image1 = toImageEntityC(file);
            image1.setPreviewImage(true);
            news.addImageToNews(image1);
        }
        News newsFromDb = newsRepository.save(news);
        newsFromDb.setPreviewImageId(newsFromDb.getImages().get(0).getId());
        newsRepository.save(news);
    }

    public void update(Long id, News news, MultipartFile file) throws IOException {
        News updatedNews= findById(id);
        updatedNews.setTitle(news.getTitle());
        updatedNews.setUnderTitleText(news.getUnderTitleText());
        updatedNews.setDescription(news.getDescription());
        updatedNews.setProductsId(news.getProductsId());
        Image image1;
        if (file.getSize() != 0) {
            image1 = toImageEntityC(file);
            image1.setPreviewImage(true);
            updatedNews.getImages().get(0).setName(image1.getName());
            updatedNews.getImages().get(0).setOriginalFileName(image1.getOriginalFileName());
            updatedNews.getImages().get(0).setContentType(image1.getContentType());
            updatedNews.getImages().get(0).setSize(image1.getSize());
            updatedNews.getImages().get(0).setBytes(image1.getBytes());
            log.info("Название" + image1.getOriginalFileName());
        }
        newsRepository.save(updatedNews);
    }

    public void deleteById(Long id) {
        newsRepository.deleteById(id);
    }

    private Image toImageEntityC(MultipartFile file) throws IOException {
        Image image1 = new Image();
        image1.setName(file.getName());
        image1.setOriginalFileName(file.getOriginalFilename());
        image1.setContentType(file.getContentType());
        image1.setSize(file.getSize());
        image1.setBytes(file.getBytes());
        return image1;
    }



}
