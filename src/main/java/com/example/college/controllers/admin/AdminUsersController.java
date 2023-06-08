package com.example.college.controllers.admin;

import com.example.college.models.User;
import com.example.college.services.TelegramBotService;
import com.example.college.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminUsersController {

    private final UserService userService;
    private final TelegramBotService telegramBotService;

    @PostMapping("/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id,HttpServletRequest request, HttpServletResponse response) {
        userService.banUser(id);
        return referer(request,response);
    }

    @PostMapping("/user/edit/{id}")
    public String userEdit(@PathVariable("id") Long id, @RequestParam Map<String, String> form,HttpServletRequest request, HttpServletResponse response) {
        User user = userService.getById(id);
        userService.changeUserRoles(user, form);
        return referer(request,response);
    }

    @PostMapping("/tg/messages")
    public String tgMessages(@RequestParam("messageText") String message,HttpServletRequest request, HttpServletResponse response){
        telegramBotService.sendingMessageToTgUsers(message);
        return referer(request,response);
    }

    public String referer(HttpServletRequest request, javax.servlet.http.HttpServletResponse response){
        String referer = "/admin";// Get the referer URL
        try {
            response.sendRedirect(referer); // Redirect back to the same page
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
