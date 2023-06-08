package com.example.college.services;

import com.example.college.models.*;
import com.example.college.models.enums.Status;
import com.example.college.repositories.OrderRepository;
import com.example.college.repositories.UserRepository;
import com.example.college.util.CartUtil;
import com.example.college.util.JavaMailSenderUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.telegram.telegrambots.meta.api.objects.Update;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderService {


    private final OrderRepository orderRepository;
    private final CartUtil cartUtil;
    private final JavaMailSenderUtil javaMailSenderUtil;

    private final ProductService productService;

    private final UserRepository userRepository;

    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    public Order findById(Long id){
        return orderRepository.getById(id);
    }
    public Order findByUuid(String uuid){
        return orderRepository.findOrderByUuid(uuid);
    }


    public boolean save(Order order, Principal principal, HttpServletRequest request, HttpServletResponse response, PostalData postalData, Update update) throws IOException {
        if (postalData.getLastName().isEmpty()) return false;
        if (postalData.getName().isEmpty()) return false;
        if (postalData.getSurname().isEmpty()) return false;
        if (postalData.getPostalIndex().isEmpty()) return false;
        if (postalData.getCity().isEmpty()) return false;
        if (postalData.getStreet().isEmpty()) return false;
        if (postalData.getHouseNumber().isEmpty()) return false;
        order.setStatus(String.valueOf(Status.В_ОБРАБОТКЕ));
        order.setUser(getUserByPrincipal(principal));

        order.setProductsIdAndSize(getProductAndSizes(request, response));

        order.setTotalPrice(totalPrice(request, response));
        order.setPostalData(postalData);
        orderRepository.save(order);
        javaMailSenderUtil.messageToEmail(getUserByPrincipal(principal).getEmail(), order, "Уведомление о заказе!", javaMailSenderUtil.createOrderMailConten(order));
        return true;
    }


    private Map<Long, String> getProductAndSizes(HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = cartUtil.getCart(request, response);
        Map<Long, String> idAndSize = cart.stream()
                .flatMap(c -> c.getIdAndSize().entrySet().stream())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
        return idAndSize;
    }


    public int totalPrice(HttpServletRequest request, HttpServletResponse response) {
        List<Cart> cart = cartUtil.getCart(request, response);
        int totalPriceInOrder = cart.stream()
                .mapToInt(Cart::getPrice) // получение цены каждого продукта
                .sum(); // суммирование всех цен
        return totalPriceInOrder;
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }


    public Order updateByUuid(String uuid) {
        Order order = orderRepository.findOrderByUuid(uuid);
        order.setUuid(null);
        order.setStatus(String.valueOf(Status.ОТМЕНЁН));
        return orderRepository.save(order);
    }

    public Order update(Long id, Status status) {
        Order order = orderRepository.getById(id);
        order.setStatus(status.getAuthority());
        if (order.getStatus().equals("ДОСТАВЛЕН")) {
            order.setDeliveryDate(LocalDateTime.now());
            processOrder(order);
        }
        return orderRepository.save(order);
    }

    public List<Map.Entry<Long, String>> processOrder(Order order) {
        List<Map.Entry<Long, String>> result = new ArrayList<>();

        if (!order.getStatus().equals(Status.В_ОБРАБОТКЕ.name()) &&
                !order.getStatus().equals(Status.ОТМЕНЁН.name())) {
            for (Map.Entry<Long, String> entry : order.getProductsIdAndSize().entrySet()) {
                Long productId = entry.getKey();
                String selectedSize = entry.getValue();

                Product product = productService.getProductById(productId);
                if (product != null) {
                    Map<String, Integer> dimensions = product.getDimensions();
                    if (dimensions.containsKey(selectedSize)) {
                        int quantity = dimensions.get(selectedSize);
                        if (quantity > 0) {
                            dimensions.put(selectedSize, quantity - 1);

                            Map.Entry<Long, String> productData = new HashMap.SimpleEntry<>(productId, selectedSize);
                            result.add(productData);
                        }
                    }
                }
            }
        }
        return result;
    }


}
