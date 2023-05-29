package com.example.college.services;

import com.example.college.models.Order;
import com.example.college.models.ProductStatistics;
import com.example.college.models.User;
import com.example.college.repositories.OrderRepository;
import com.example.college.repositories.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AnalyticsService {

    private final OrderRepository orderRepository;

    private final ProductRepository productRepository;

    public int getTotalRevenue() {
        List<Order> orders = orderRepository.findAll();
        int totalRevenue = 0;

        for (Order order : orders) {
            totalRevenue += order.getTotalPrice();
        }

        return totalRevenue;
    }

    public double getAverageOrderValue() {
        List<Order> orders = orderRepository.findAll();
        int totalRevenue = getTotalRevenue();
        int totalOrders = orders.size();

        if (totalOrders == 0) {
            return 0;
        }

        return (double) totalRevenue / totalOrders;
    }

    public int getTotalNumberOfOrders() {
        List<Order> orders = orderRepository.findAll();
        return orders.size();
    }

    public int getTotalNumberOfUsers() {
        List<Order> orders = orderRepository.findAll();
        Set<User> uniqueUsers = new HashSet<>();

        for (Order order : orders) {
            uniqueUsers.add(order.getUser());
        }

        return uniqueUsers.size();
    }

    public double getAverageOrderPerUser() {
        int totalOrders = getTotalNumberOfOrders();
        int totalUsers = getTotalNumberOfUsers();

        if (totalUsers == 0) {
            return 0;
        }

        return (double) totalOrders / totalUsers;
    }

    public User getMostActiveUser() {
        List<Order> orders = orderRepository.findAll();
        Map<User, Integer> userOrderCounts = new HashMap<>();

        for (Order order : orders) {
            User user = order.getUser();
            userOrderCounts.put(user, userOrderCounts.getOrDefault(user, 0) + 1);
        }

        Optional<Map.Entry<User, Integer>> maxEntry = userOrderCounts.entrySet().stream()
                .max(Map.Entry.comparingByValue());

        return maxEntry.map(Map.Entry::getKey).orElse(null);
    }

    public Map<String, Integer> getOrderStatusBreakdown() {
        List<Order> orders = orderRepository.findAll();
        Map<String, Integer> statusCounts = new HashMap<>();

        for (Order order : orders) {
            String status = order.getStatus();
            statusCounts.put(status, statusCounts.getOrDefault(status, 0) + 1);
        }

        return statusCounts;
    }


    public Map<String, Integer> getOrderValueDistribution() {
        List<Order> orders = orderRepository.findAll();
        Map<String, Integer> valueDistribution = new HashMap<>();

        for (Order order : orders) {
            int orderValue = order.getTotalPrice();

            if (orderValue <= 100) {
                valueDistribution.put("0-100", valueDistribution.getOrDefault("0-100", 0) + 1);
            } else if (orderValue <= 500) {
                valueDistribution.put("101-500", valueDistribution.getOrDefault("101-500", 0) + 1);
            } else if (orderValue <= 1000) {
                valueDistribution.put("501-1000", valueDistribution.getOrDefault("501-1000", 0) + 1);
            } else {
                valueDistribution.put("1001+", valueDistribution.getOrDefault("1001+", 0) + 1);
            }
        }

        return valueDistribution;
    }


    public Map<Long, List<String>> getPopularProductSizes() {
        List<Order> orders = orderRepository.findAll();
        Map<Long, List<String>> productSizes = new HashMap<>();

        for (Order order : orders) {
            for (Map.Entry<Long, String> entry : order.getProductsIdAndSize().entrySet()) {
                Long productId = entry.getKey();
                String size = entry.getValue();
                List<String> sizes = productSizes.getOrDefault(productId, new ArrayList<>());
                sizes.add(size);
                productSizes.put(productId, sizes);
            }
        }

        return productSizes;
    }



    public List<ProductStatistics> getMostPopularProducts(int limit) {
        List<Order> orders = orderRepository.findAll();
        Map<String, ProductStatistics> productStatisticsMap = new HashMap<>();

        for (Order order : orders) {
            for (Map.Entry<Long, String> entry : order.getProductsIdAndSize().entrySet()) {
                Long productId = entry.getKey();
                String size = entry.getValue();
                String key = productId + "-" + size;

                ProductStatistics productStatistics = productStatisticsMap.getOrDefault(key, new ProductStatistics(productId, size));
                productStatistics.incrementPurchaseCount();
                productStatisticsMap.put(key, productStatistics);
            }
        }

        List<ProductStatistics> sortedProductStatistics = new ArrayList<>(productStatisticsMap.values());
        sortedProductStatistics.sort(Comparator.comparingInt(ProductStatistics::getPurchaseCount).reversed());

        List<ProductStatistics> popularProducts = sortedProductStatistics.stream()
                .limit(limit)
                .collect(Collectors.toList());

        return popularProducts;
    }


    public List<User> getFrequentBuyers(int limit) {
        List<Order> orders = orderRepository.findAll();
        Map<User, Integer> userPurchaseCounts = new HashMap<>();

        for (Order order : orders) {
            User user = order.getUser();
            userPurchaseCounts.put(user, userPurchaseCounts.getOrDefault(user, 0) + 1);
        }

        List<Map.Entry<User, Integer>> sortedPurchaseCounts = new ArrayList<>(userPurchaseCounts.entrySet());
        sortedPurchaseCounts.sort(Map.Entry.comparingByValue(Comparator.reverseOrder()));

        List<User> frequentBuyers = sortedPurchaseCounts.stream()
                .limit(limit)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        return frequentBuyers;
    }

}
