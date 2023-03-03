package com.example.college.services;


import com.example.college.models.Image;
import com.example.college.models.Product;
import com.example.college.models.User;
import com.example.college.repositories.ProductRepository;
import com.example.college.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Product> listProducts(String title) {
        if (title != null) return productRepository.findByTitle(title);
        return productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product, MultipartFile fileProduct1, MultipartFile fileProduct2, MultipartFile fileProduct3, String dimensions) throws IOException {
        product.setUser(getUserByPrincipal(principal));
//        product.setPopular(false);
        Image image1;
        Image image2;
        Image image3;
        if (fileProduct1.getSize() != 0) {
            image1 = toImageEntity(fileProduct1);
            image1.setPreviewImage(true);
            product.setPreviewImageId(image1.getId());

        }
        if (fileProduct2.getSize() != 0) {
            image2 = toImageEntity(fileProduct2);
            product.addImageToProduct(image2);
        }
        if (fileProduct3.getSize() != 0) {
            image3 = toImageEntity(fileProduct3);
            product.addImageToProduct(image3);
        }

        log.info("Saving new Product. Title: {}; imageid: {}; Author email: {}", product.getTitle(), product.getPreviewImageId(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());

        productRepository.save(product);
    }

    public List<Product> getProductsByFilter(String title, String city, Long categoryId) {
        if (title == null) {
            title = "";
            productRepository.findAll();
        }else if (city == null && categoryId == null) {
            // If all parameters are null, return all products
            return productRepository.findAll();
        } else if (city != null && categoryId != null) {
            // If all parameters are not null, use all three parameters in the query
            return productRepository.findByTitleContainingAndCityContainingAndCategoryId(title, city, categoryId);
        }
       return productRepository.findByTitleContainingAndCityContainingAndCategoryId(title, city, categoryId);
    }


    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
