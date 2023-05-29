package com.example.college.controllers;

import com.example.college.models.Filter;
import com.example.college.util.FilterUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/products")
@RequiredArgsConstructor
@Slf4j
public class FilterController {

    private final FilterUtil filterUtil;

    @PostMapping("/filter/add")
    public String addToFilter(HttpServletRequest request, HttpServletResponse response,
                            Filter filter) {
        Filter updatingFilter = new Filter();
        if (filterUtil.getFilter(request,response) != null && filterUtil.getFilter(request,response).toString().length() > 0){
            Filter currentFilter = filterUtil.getFilter(request, response);
            //Категория
            if (filterUtil.getFilter(request,response).getCategory() != null && filterUtil.getFilter(request,response).getCategory().size() > 0 && filter.getCategory() != null) {
                Set<String> categorySet = new HashSet<>(currentFilter.getCategory());
                categorySet.addAll(filter.getCategory());
                List<String> categoriesList = new ArrayList<>(categorySet);
                updatingFilter.setCategory(categoriesList);
//                updatingFilter.setBrand(new String[]{filterUtil.getFilter(request, response).getBrand() + "," + filter.getBrand()});
            }
            if (filterUtil.getFilter(request,response).getCategory() == null || filterUtil.getFilter(request,response).getCategory().size()<=0 && filter.getCategory() != null){
                updatingFilter.setCategory(filter.getCategory());
            }
            if (filter.getCategory() == null){
                updatingFilter.setCategory(currentFilter.getCategory());
            }
            //бренд
            if (filterUtil.getFilter(request,response).getBrand() != null && filterUtil.getFilter(request,response).getBrand().size() > 0 && filter.getBrand() != null) {
                Set<String> brandSet = new HashSet<>(currentFilter.getBrand());
                brandSet.addAll(filter.getBrand());
                List<String> brandList = new ArrayList<>(brandSet);
                updatingFilter.setBrand(brandList);
//                updatingFilter.setBrand(new String[]{filterUtil.getFilter(request, response).getBrand() + "," + filter.getBrand()});
            }
            if (filterUtil.getFilter(request,response).getBrand() == null || filterUtil.getFilter(request,response).getBrand().size()<=0 && filter.getBrand() != null){
                updatingFilter.setBrand(filter.getBrand());
            }
            if (filter.getBrand() == null){
                updatingFilter.setBrand(currentFilter.getBrand());
            }
            //Размер
            if (filterUtil.getFilter(request,response).getDimension() != null && filterUtil.getFilter(request,response).getDimension().size() > 0 && filter.getDimension() != null) {
                Set<String> sizeSet = new HashSet<>(currentFilter.getDimension());
                sizeSet.addAll(filter.getBrand());
                List<String> sizeList = new ArrayList<>(sizeSet);
                updatingFilter.setBrand(sizeList);
            }
            if (filterUtil.getFilter(request,response).getDimension() == null || filterUtil.getFilter(request,response).getDimension().size()<=0 && filter.getDimension() != null){
                updatingFilter.setDimension(filter.getDimension());
            }
            if (filter.getDimension() == null){
                updatingFilter.setDimension(currentFilter.getDimension());
            }
            //цвет
            if (filterUtil.getFilter(request,response).getColor() != null && filterUtil.getFilter(request,response).getColor().size() > 0 && filter.getColor() != null) {
                Set<String> colorSet = new HashSet<>(currentFilter.getColor());
                colorSet.addAll(filter.getColor());
                List<String> colorList = new ArrayList<>(colorSet);
                updatingFilter.setBrand(colorList);
            }
            if (filterUtil.getFilter(request,response).getColor() == null || filterUtil.getFilter(request,response).getColor().size()<=0 && filter.getColor() != null){
                updatingFilter.setColor(filter.getColor());
            }
            if (filter.getColor() == null){
                updatingFilter.setColor(currentFilter.getColor());
            }
        }
        else {
            filterUtil.addToFilter(response, filter);
        }
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");


        updatingFilter.setMinPrice(minPriceStr);
        updatingFilter.setMaxPrice(maxPriceStr);

        filterUtil.updateFilter(response, updatingFilter);
        return productsRedirect(request,response);
    }

    @PostMapping("/one/filter/{param}")
    public String addOneParamToFilterCategory(@PathVariable("param") String wordToRemove,
                            HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
        }
        Filter filter = filterUtil.getFilter(request, response);
        filterUtil.removeAllFilter(request, response, filter);

        List<String> category = new ArrayList<>();
        category.add(wordToRemove);
        filter.setCategory(category);

        filterUtil.addToFilter(response, filter);
        return productsRedirect(request, response);
    }

    @PostMapping("/one/filter/brand/{param}")
    public String addOneParamToFilterBrand(@PathVariable("param") String wordToRemove,
                                      HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
        }
        Filter filter = filterUtil.getFilter(request, response);
        filterUtil.removeAllFilter(request, response, filter);

        List<String> brand = new ArrayList<>();
        brand.add(wordToRemove);
        filter.setBrand(brand);

        filterUtil.addToFilter(response, filter);
        return productsRedirect(request, response);
    }
    @PostMapping("/one/filter/color/{param}")
    public String addOneParamToFilterColor(@PathVariable("param") String wordToRemove,
                                           HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
        }
        Filter filter = filterUtil.getFilter(request, response);
        filterUtil.removeAllFilter(request, response, filter);

        List<String> color = new ArrayList<>();
        color.add(wordToRemove);
        filter.setColor(color);

        filterUtil.addToFilter(response, filter);
        return productsRedirect(request, response);
    }


    @PostMapping("/filter/delete/{name}")
    public String deleteFilterItem(@PathVariable("name") String wordToRemove, HttpServletRequest request, HttpServletResponse response) {
        filterUtil.removeFromCart(wordToRemove,request,response);
        return referer(request,response);
    }

    @PostMapping("/filter/remove")
    public String removeAllFilter(HttpServletRequest request,HttpServletResponse response, Filter filter){
        filterUtil.removeAllFilter(request,response,filter);
        return referer(request,response);
    }




    public String referer(HttpServletRequest request, HttpServletResponse response) {
        String referer = request.getHeader("Referer"); // Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String productsRedirect(HttpServletRequest request, HttpServletResponse response) {
        String referer = "/products"; // Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
