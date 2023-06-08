package com.example.college.controllers.admin;

import com.example.college.models.Order;
import com.example.college.models.enums.Status;
import com.example.college.services.OrderService;
import com.example.college.services.TelegramBotService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/admin/orders")
@RequiredArgsConstructor
public class AdminOrdersController {

    private final OrderService orderService;
    private final TelegramBotService telegramBotService;


    @PostMapping("/update/{id}")
    public String orderUpdate(@PathVariable("id") Long id, @RequestParam("status") Status status,HttpServletRequest request, HttpServletResponse response) {
        orderService.update(id,status);
        Order order = orderService.findById(id);
        Long chatId = order.getUser().getTelegramUser().getChatId();
        if (chatId != null) {
            telegramBotService.createMessages(chatId, "Статус вашего заказа обновлён на:" + order.getStatus().toString() + ". Подробную информацию вы можете узнать на сайте, в своём профиле.");
        }
        return referer(request,response);
    }

    public String referer(HttpServletRequest request, HttpServletResponse response){
        String referer = "/admin/orders";// Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
