package com.example.college.controllers;


import com.example.college.models.Order;
import com.example.college.models.User;
import com.example.college.services.OrderService;
import com.example.college.services.ProductService;
import com.example.college.services.UserService;
import com.example.college.util.JavaMailSenderUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class UserController {
    private final UserService userService;
    private final JavaMailSenderUtil javaMailSenderUtil;
    private final ProductService productService;

    @GetMapping("/login")
    public String login(User user, Model model) {
        if (user.getEmail() == null && user.getPassword()==null) {
            model.addAttribute("errorMessageLogin", "Проверьте правильность написания логина или пароля");
        }
        return "login";
    }


    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }


    @PostMapping("/registration")
    public String createUser(User user, Model model) {
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/login/activate/{code}")
    public String activate(Model model, @PathVariable String code, RedirectAttributes redirectAttributes){
        boolean isActivated = userService.activateUser(code);
        if (isActivated) {
            redirectAttributes.addFlashAttribute("message1", "Пользователь успешно подтверждён");
        } else {
            redirectAttributes.addFlashAttribute("message1", "Пользователь не подтверждён");
        }
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("orders", user.getOrder());
        model.addAttribute("productService", productService); // Добавьте ProductService в модель
        return "user-info";
    }

    @PostMapping("/user/updatePassword/{id}")
    public String updatePassword(@PathVariable("id") User user,
                                @RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("twoOldPassword") String twoOldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 Principal principal,
                                 RedirectAttributes redirectAttributes) {
        boolean isPasswordUpdated = userService.updatePassword(user.getId(), oldPassword, newPassword, twoOldPassword);
        log.info(oldPassword);
        log.info(newPassword);
        log.info(twoOldPassword);
        if (isPasswordUpdated) {
            redirectAttributes.addFlashAttribute("successMessage", "Пароль успешно обновлен");
            log.info("даа");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при обновлении пароля");
            log.info("нетт");
        }

        return "redirect:/user/" + user.getId();
    }

    @PostMapping("/email/message/{id}")
    public String resendMessageToEmail(@PathVariable("id") Long id,
                                       RedirectAttributes redirectAttributes){
        boolean resendMail = userService.activateUserMessage(id);
        if (resendMail){
            redirectAttributes.addFlashAttribute("messageMail", "Сообщение отправлено, проверите вашу почту.");
            log.info("даа");
        } else {
            redirectAttributes.addFlashAttribute("messageMail", "Ошибка, возможно вы ошиблись, при регистрации.Зарегистрируйте новый аккаунт.");
            log.info("нетт");
        }
        return "redirect:/";
    }


    @PostMapping("/telegram/user/{id}")
    public String newTelegramUserConnect(@PathVariable("id") Long id,
                                       RedirectAttributes redirectAttributes, String code){
       boolean connectedUsers =  userService.setTelegramUserToUser(id,code);
       if (connectedUsers){
           redirectAttributes.addFlashAttribute("messageTg", "Вы успешно соединились с телеграмм профилем.");
           log.info("даа");
       } else {
           redirectAttributes.addFlashAttribute("errorMessageTg", "Ошибка, возможно вы ошиблись при вводе кода");
           log.info("нетт");
       }
        return "redirect:/user/" + id;
    }
}
