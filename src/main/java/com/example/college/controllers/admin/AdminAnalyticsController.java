package com.example.college.controllers.admin;

import com.example.college.models.ProductStatistics;
import com.example.college.models.User;
import com.example.college.services.AnalyticsService;
import com.example.college.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminAnalyticsController {

    private final AnalyticsService analyticsService;

    private final ProductService productService;

    @GetMapping("/admin/analytics")
    public String homePage(Model model) {
        int totalRevenue = analyticsService.getTotalRevenue();
        double averageOrderValue = analyticsService.getAverageOrderValue();
        int totalNumberOfOrders = analyticsService.getTotalNumberOfOrders();
        int totalNumberOfUsers = analyticsService.getTotalNumberOfUsers();
        double averageOrderPerUser = analyticsService.getAverageOrderPerUser();
        User mostActiveUser = analyticsService.getMostActiveUser();
        Map<String, Integer> orderStatusBreakdown = analyticsService.getOrderStatusBreakdown();
        Map<String, Integer> orderValueDistribution = analyticsService.getOrderValueDistribution();
        Map<Long, List<String>> popularProductSizes = analyticsService.getPopularProductSizes();
        List<ProductStatistics> mostPopularProducts = analyticsService.getMostPopularProducts(5);
        List<User> frequentBuyers = analyticsService.getFrequentBuyers(10);

        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("averageOrderValue", averageOrderValue);
        model.addAttribute("totalNumberOfOrders", totalNumberOfOrders);
        model.addAttribute("totalNumberOfUsers", totalNumberOfUsers);
        model.addAttribute("averageOrderPerUser", averageOrderPerUser);
        model.addAttribute("mostActiveUser", mostActiveUser);
        model.addAttribute("orderStatusBreakdown", orderStatusBreakdown);
        model.addAttribute("orderValueDistribution", orderValueDistribution);
        model.addAttribute("popularProductSizes", popularProductSizes);
        model.addAttribute("mostPopularProducts", mostPopularProducts);
        model.addAttribute("frequentBuyers", frequentBuyers);

        model.addAttribute("productService",productService);
        return "admin-analytics";

    }
}
