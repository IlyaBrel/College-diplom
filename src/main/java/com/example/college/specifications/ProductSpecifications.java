package com.example.college.specifications;

import com.example.college.models.Category;
import com.example.college.models.Product;

import com.example.college.models.product.properties.Brand;
import com.example.college.models.product.properties.Color;
import org.springframework.data.jpa.domain.Specification;
import javax.persistence.criteria.*;

public class ProductSpecifications {

    public static Specification<Product> filterByCategory(String[] categoryNames) {
        return (root, query, criteriaBuilder) -> {
            Join<Product, Category> categoryJoin = root.join("category");
            return categoryJoin.get("name").in((Object[]) categoryNames);
        };
    }

    public static Specification<Product> filterByBrand(String[] brandNames) {
        return (root, query, criteriaBuilder) -> {
            Join<Product, Brand> brandJoin = root.join("brand");
            return brandJoin.get("name").in((Object[]) brandNames);
        };
    }

    public static Specification<Product> filterByColor(String[] colorNames) {
        return (root, query, criteriaBuilder) -> {
            Join<Product, Color> colorJoin = root.join("color");
            return colorJoin.get("name").in((Object[]) colorNames);
        };
    }

    public static Specification<Product> filterBySize(String[] sizeKeys) {
        return (root, query, criteriaBuilder) -> {
            MapJoin<Product, String, Integer> sizeMapJoin = root.joinMap("dimensions");
            return sizeMapJoin.key().in((Object[]) sizeKeys);
        };
    }


    public static Specification<Product> filterByPrice(int minPrice, int maxPrice) {
        return (root, query, criteriaBuilder) -> {
            return criteriaBuilder.between(root.get("price"), minPrice, maxPrice);
        };
    }
}
