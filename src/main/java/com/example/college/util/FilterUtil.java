package com.example.college.util;

import com.example.college.models.Cart;
import com.example.college.models.Filter;
import com.example.college.services.CategoryService;
import com.example.college.services.ProductService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


@Component
@Slf4j
@RequiredArgsConstructor
public class FilterUtil {

    private final CategoryService categoryService;
    private static final String FILTER_COOKIE_NAME = "filters";
    private static final ObjectMapper objectMapper = new ObjectMapper();


    public Filter getFilter(HttpServletRequest request, HttpServletResponse response) {
        Filter filter = getCartFromCookie(request);
        return filter;
    }

    public void addToFilter(HttpServletResponse response,
                            Filter filter) {
        saveCartToCookie(response, filter);
    }

    public void updateFilter(HttpServletResponse response, Filter filter) {
        saveCartToCookie(response, filter);
    }

    public Filter removeFromCart(@PathVariable("index") String wordToRemove, HttpServletRequest request, HttpServletResponse response) {
        Filter filter = getCartFromCookie(request);
//        filter.getCategory().remove(index);
        List<List<String>> nestedList = new ArrayList<>();
        if (filter.getCategory() !=null){
            nestedList.add(filter.getCategory());
        }
        if (filter.getBrand() != null){
            nestedList.add(filter.getBrand());
        }
        if (filter.getDimension() !=null){
            nestedList.add(filter.getDimension());
        }
        if (filter.getColor() !=null){
            nestedList.add(filter.getColor());
        }
        // Поиск и удаление слова во вложенных списках
        for (List<String> list : nestedList) {
            for (int i = 0; i < list.size(); i++) {
                String word = list.get(i);
                if (word.equals(wordToRemove)) {
                    list.remove(i);
                    i--;
                }
            }
        }
        saveCartToCookie(response, filter);
        return filter;
    }

    public Filter removeAllFilter( HttpServletRequest request, HttpServletResponse response,Filter filter){
        filter = getFilter(request,response);
        filter.setCategory(new ArrayList<>());
        filter.setBrand(new ArrayList<>());
        filter.setColor(new ArrayList<>());
        filter.setDimension(new ArrayList<>());
        filter.setMinPrice(String.valueOf(0));
        filter.setMaxPrice(String.valueOf(1000));
        saveCartToCookie(response, filter);
        return filter;
    }

    public List<String> getAllFinder(HttpServletRequest request, HttpServletResponse response){
        Filter filter = getCartFromCookie(request);
        List<String> finderFilter = new ArrayList<>();
        if (filter.getCategory() !=null){
            finderFilter.addAll(filter.getCategory());
        }
        if (filter.getBrand() !=null){
            finderFilter.addAll(filter.getBrand());
        }
        if (filter.getDimension() !=null){
            finderFilter.addAll(filter.getDimension());
        }
        if (filter.getColor() !=null){
            finderFilter.addAll(filter.getColor());
        }
        return finderFilter;
    }

    private Filter getCartFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        Filter filter = new Filter();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (FILTER_COOKIE_NAME.equals(cookie.getName())) {
                    try {
                        filter = objectMapper.readValue(URLDecoder.decode(cookie.getValue(), "UTF-8"), new TypeReference<Filter>() {
                        });
                    } catch (IOException e) {
                        log.error("Failed to read filter from cookie", e);
                    }
                }
            }
        }
        return filter;
    }

    private void saveCartToCookie(HttpServletResponse response, Filter filter) {
        try {
            Cookie cookie = new Cookie(FILTER_COOKIE_NAME, URLEncoder.encode(objectMapper.writeValueAsString(filter), "UTF-8"));
            cookie.setPath("/");
            response.addCookie(cookie);
        } catch (JsonProcessingException e) {
            log.error("Failed to write cart to cookie", e);
        } catch (UnsupportedEncodingException e) {
            log.error("Failed to encode cart value", e);
        }
    }
}
