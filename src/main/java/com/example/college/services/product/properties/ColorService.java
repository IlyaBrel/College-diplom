package com.example.college.services.product.properties;

import com.example.college.models.productProperties.Color;
import com.example.college.repositories.ColorRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ColorService {

    private final ColorRepository colorRepository;


    public Color findById(Long id) {
        return colorRepository.findById(id).orElse(null);
    }

    public Page<Color> findFirst6Employees() {
        return colorRepository.findAll(PageRequest.of(0, 6));
    }

    public List<Color> findAll() {
        return colorRepository.findAll();
    }

    public void save(Color color) throws IOException {
        colorRepository.save(color);
    }

    public void update(Long id, Color color) throws IOException{
        Color newColor = colorRepository.getById(id);
        newColor.setName(color.getName());
        newColor.setStyle(color.getStyle());
        colorRepository.save(color);
    }

    public boolean deleteById(Long id) {
        colorRepository.deleteById(id);
        return true;
    }
}
