package com.example.college.services.product.properties;

import com.example.college.models.Category;
import com.example.college.models.Image;
import com.example.college.models.productProperties.Brand;
import com.example.college.repositories.BrandRepository;
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
public class BrandService {

    private final BrandRepository brandRepository;


    public Brand findById(Long id) {
        return brandRepository.findById(id).orElse(null);
    }

    public Page<Brand> findFirst6Employees() {
        return brandRepository.findAll(PageRequest.of(0, 6));
    }

    public List<Brand> findAll() {
        return brandRepository.findAll();
    }

    public void save(Brand brand) throws IOException {
        brandRepository.save(brand);
    }

    public void update(Long id, Brand brand) throws IOException  {
        Brand newBrand = findById(id);
        newBrand.setName(brand.getName());
        brandRepository.save(newBrand);
    }

    public boolean deleteById(Long id) {
        brandRepository.deleteById(id);
        return true;
    }
}
