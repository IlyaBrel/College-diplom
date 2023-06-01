package com.example.college.services;


import com.example.college.services.product.properties.BrandService;
import com.example.college.specifications.ProductSpecifications;
import com.example.college.models.Image;
import com.example.college.models.Product;
import com.example.college.models.User;
import com.example.college.repositories.ProductRepository;
import com.example.college.repositories.UserRepository;
import com.example.college.util.FilterUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final FilterUtil filterUtil;
    private final BrandService brandService;
    private final CategoryService categoryService;


    public List<Product> listProducts(String title) {
        return title != null ? productRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(title, title) : productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product,
                            MultipartFile fileProduct1, MultipartFile fileProduct2, MultipartFile fileProduct3,
                            List<String> dimension, List<Integer> quantities) throws IOException {
        product.setUser(getUserByPrincipal(principal));

        Map<String, Integer> dimensions = new HashMap<>();
        for (int i = 0; i < dimension.size(); i++) {
            dimensions.put(dimension.get(i), quantities.get(i));
        }
        product.setDimensions(dimensions);
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

    public boolean deleteProduct(Long id) {
        productRepository.deleteById(id);
        return true;
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public List<Product> getProductsByFilters(String[] categories, String[] brands, String[] colors, String[] sizes, int minPrice, int maxPrice) {
        Specification<Product> spec = Specification.where(null);

        if (categories != null && categories.length > 0) {
            spec = spec.and(ProductSpecifications.filterByCategory(categories));
        }
        if (brands != null && brands.length > 0) {
            spec = spec.and(ProductSpecifications.filterByBrand(brands));
        }
        if (sizes != null && sizes.length > 0) {
            spec = spec.and(ProductSpecifications.filterBySize(sizes));
        }
        if (colors != null && colors.length > 0) {
            spec = spec.and(ProductSpecifications.filterByColor(colors));
        }
        if (minPrice >= 0 && maxPrice > 0) {
            spec = spec.and(ProductSpecifications.filterByPrice(minPrice, maxPrice));
        }
        return productRepository.findAll(spec);
    }

    Set<String> selectedFiltersList = new HashSet<>();


    public List<Product> selectedFilters(HttpServletRequest request, HttpServletResponse response) {

        if (filterUtil.getFilter(request, response).getCategory() != null && filterUtil.getFilter(request, response).getCategory().toArray().length > 0) {
            for (String category : filterUtil.getFilter(request, response).getCategory()) {
                if (!selectedFiltersList.contains(category)) {
                    selectedFiltersList.add(category);
                }
            }
        }
        if (filterUtil.getFilter(request, response).getBrand() != null && filterUtil.getFilter(request, response).getBrand().toArray().length > 0) {
            for (String brand : filterUtil.getFilter(request, response).getBrand()) {
                if (!selectedFiltersList.contains(brand)) {
                    selectedFiltersList.add(brand);
                }
            }
        }
        if (filterUtil.getFilter(request, response).getColor() != null && filterUtil.getFilter(request, response).getColor().toArray().length > 0) {
            for (String color : filterUtil.getFilter(request, response).getColor()) {
                if (!selectedFiltersList.contains(color)) {
                    selectedFiltersList.add(color);
                }
            }
        }
        if (filterUtil.getFilter(request, response).getDimension() != null && filterUtil.getFilter(request, response).getDimension().toArray().length > 0) {
            for (String size : filterUtil.getFilter(request, response).getDimension()) {
                if (!selectedFiltersList.contains(size)) {
                    selectedFiltersList.add(size);
                }
            }
        }
        String[] myArrayCategory = new String[categoryService.findAll().size()];

        if (filterUtil.getFilter(request, response).getCategory() != null) {
            myArrayCategory = filterUtil.getFilter(request, response).getCategory().stream().toArray(String[]::new);
        } else {
            myArrayCategory = new ArrayList<>().stream().toArray(String[]::new);
        }
        String[] myArrayBrand = new String[brandService.findAll().size()];
        if (filterUtil.getFilter(request, response).getBrand() != null) {
            myArrayBrand = filterUtil.getFilter(request, response).getBrand().stream().toArray(String[]::new);
        } else {
            myArrayBrand = new ArrayList<>().stream().toArray(String[]::new);
        }
        String[] myArraySize = new String[brandService.findAll().size()];
        if (filterUtil.getFilter(request, response).getDimension() != null) {
            myArraySize = filterUtil.getFilter(request, response).getDimension().stream().toArray(String[]::new);
        } else {
            myArraySize = new ArrayList<>().stream().toArray(String[]::new);
        }
        String[] myArrayColor = new String[brandService.findAll().size()];
        if (filterUtil.getFilter(request, response).getColor() != null) {
            myArrayColor = filterUtil.getFilter(request, response).getColor().stream().toArray(String[]::new);
        } else {
            myArrayColor = new ArrayList<>().stream().toArray(String[]::new);
        }
        String minPriceString = filterUtil.getFilter(request, response).getMinPrice();
        String maxPriceString = filterUtil.getFilter(request, response).getMaxPrice();
        int minPrice = minPriceString != null ? Integer.parseInt(minPriceString.trim()) : 0;
        int maxPrice = maxPriceString != null ? Integer.parseInt(maxPriceString.trim()) : Integer.MAX_VALUE;
        return getProductsByFilters(
                myArrayCategory,
                myArrayBrand,
                myArrayColor,
                myArraySize,
                minPrice,
                maxPrice);
    }

    public Set<String> getSelectedFiltersList() {
        return selectedFiltersList;
    }


    public int getMinPriceProduct() {
        List<Product> productList = productRepository.findAll();// список продуктов

        int minPrice = Integer.MAX_VALUE; // начальное значение минимальной цены
        for (Product product : productList) {
            int price = product.getPrice(); // получение цены продукта
            if (price < minPrice) {
                minPrice = price; // обновление минимальной цены, если цена продукта меньше текущей минимальной
            }
        }
        return minPrice;

    }

    public int getMaxPriceProduct() {
        List<Product> productList = productRepository.findAll();// список продуктов

        int maxPrice = Integer.MIN_VALUE; // начальное значение максимальной цены

// Проход по списку продуктов
        for (Product product : productList) {
            int price = product.getPrice(); // получение цены продукта

            if (price > maxPrice) {
                maxPrice = price; // обновление максимальной цены, если цена продукта больше текущей максимальной
            }
        }
        return maxPrice;
    }

    public List<String> getAllSizes() {
        List<Product> productList = productRepository.findAll();
        List<String> allSizes = new ArrayList<>();

        for (Product product : productList) {
            Map<String, Integer> dimensions = product.getDimensions();
            Set<String> sizes = dimensions.keySet();
            allSizes.addAll(sizes);

        }
         return allSizes.stream().distinct().collect(Collectors.toList());
    }


    public void updateProduct(Long id,Product productUpdate,
                              MultipartFile fileProduct1, MultipartFile fileProduct2, MultipartFile fileProduct3,
                              List<String> dimension, List<Integer> quantities) throws IOException {

        Product product = getProductById(id);

        product.setTitle(productUpdate.getTitle());
        product.setDescription(productUpdate.getDescription());
        product.setPrice(productUpdate.getPrice());
        if (productUpdate.getPromotionalPrice() != 0){
            product.setPromotionalPrice(productUpdate.getPromotionalPrice());
        }
        product.setCategory(productUpdate.getCategory());
        product.setColor(productUpdate.getColor());
        product.setBrand(productUpdate.getBrand());


        if (dimension.size() != 0) {
            product.getDimensions().clear();
            Map<String, Integer> dimensions = new HashMap<>();
            for (int i = 0; i < dimension.size(); i++) {
                dimensions.put(dimension.get(i), quantities.get(i));
            }
            product.setDimensions(dimensions);
        }

        Image image1;
        Image image2;
        Image image3;
        if (fileProduct1.getSize() != 0) {
            image1 = toImageEntity(fileProduct1);
            image1.setPreviewImage(true);
            product.setPreviewImageId(image1.getId());
            product.getImages().get(0).setName(image1.getName());
            product.getImages().get(0).setOriginalFileName(image1.getOriginalFileName());
            product.getImages().get(0).setContentType(image1.getContentType());
            product.getImages().get(0).setSize(image1.getSize());
            product.getImages().get(0).setBytes(image1.getBytes());

        }
        if (fileProduct2.getSize() != 0) {
            image2 = toImageEntity(fileProduct2);
            product.addImageToProduct(image2);
            product.getImages().get(1).setName(image2.getName());
            product.getImages().get(1).setOriginalFileName(image2.getOriginalFileName());
            product.getImages().get(1).setContentType(image2.getContentType());
            product.getImages().get(1).setSize(image2.getSize());
            product.getImages().get(1).setBytes(image2.getBytes());
        }
        if (fileProduct3.getSize() != 0) {
            image3 = toImageEntity(fileProduct3);
            product.addImageToProduct(image3);

            product.getImages().get(2).setName(image3.getName());
            product.getImages().get(2).setOriginalFileName(image3.getOriginalFileName());
            product.getImages().get(2).setContentType(image3.getContentType());
            product.getImages().get(2).setSize(image3.getSize());
            product.getImages().get(2).setBytes(image3.getBytes());
        }

        log.info("Saving new Product. Title: {}; imageid: {}; Author email: {}", product.getTitle(), product.getPreviewImageId(), product.getUser().getEmail());
        productRepository.save(product);
    }
}
