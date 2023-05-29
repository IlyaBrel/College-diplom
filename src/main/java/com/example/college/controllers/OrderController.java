package com.example.college.controllers;

import com.example.college.models.Cart;
import com.example.college.models.Order;
import com.example.college.models.PostalData;
import com.example.college.services.OrderService;
import com.example.college.services.UserService;
import com.example.college.util.CartUtil;
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
import java.util.ArrayList;
import java.util.List;


@Controller
@RequiredArgsConstructor
@Slf4j
public class OrderController {

    private final OrderService orderService;
    private final CartUtil cartUtil;
    private final UserService userService;

    List<String> emptyFields = new ArrayList<String>();
    PostalData postalDataNotEmpty = new PostalData();

    @GetMapping("/order")
    public String orderForm(Model model, Principal principal, HttpServletRequest request, HttpServletResponse response) {
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        List<Cart> cart = cartUtil.getCart(request, response);
        model.addAttribute("cart", cart);
        model.addAttribute("cartUtil", cartUtil);
        model.addAttribute("total-price", cartUtil.totalPrice(request));
        model.addAttribute("postalDataNotEmpty", postalDataNotEmpty);

        if (!emptyFields.isEmpty()) {
            model.addAttribute("emptyFields", emptyFields);
            log.info("Размер: " + emptyFields.size());
        }
        return "order-form";
    }


    @PostMapping("/order/new")
    public String addToCart(Order order, Principal principal, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, @RequestParam(name = "lastName") String lastName,
                            @RequestParam(name = "name", required = false) String name,
                            @RequestParam(name = "surname", required = false) String surname,
                            @RequestParam(name = "phoneNumber", required = false) String phoneNumber,
                            @RequestParam(name = "postalIndex", required = false) String postalIndex,
                            @RequestParam(name = "city", required = false) String city,
                            @RequestParam(name = "street", required = false) String street,
                            @RequestParam(name = "houseNumber", required = false) String houseNumber
    ) throws IOException {

        emptyFields.clear();
        if (lastName.isEmpty()) {
            emptyFields.add("фимилия");

        }
        if (name.isEmpty()) {
            emptyFields.add("имя;");

        }
        if (surname.isEmpty()) {
            emptyFields.add("отчество;");
        }
        if (String.valueOf(postalIndex).isEmpty()) {
            emptyFields.add("индекс;");
        }
        if (city.isEmpty()) {
            emptyFields.add("город;");
        }
        if (phoneNumber.isEmpty()) {
            emptyFields.add("номер телефона;");
        }
        if (street.isEmpty()) {
            emptyFields.add("улица;");

        }
        if (houseNumber.isEmpty()) {
            emptyFields.add("номер дома и(или) подъезда;");
        }
        if (!emptyFields.isEmpty()) {
            model.addAttribute("emptyFields", emptyFields);
            log.info("Размер:" + emptyFields.size());
            if (lastName != null && lastName.isEmpty()) {
                postalDataNotEmpty.setHouseNumber(lastName);
                model.addAttribute("lastName", postalDataNotEmpty.getLastName());
            }
            if (name != null && name.isEmpty()) {
                postalDataNotEmpty.setName(name);
                model.addAttribute("name", postalDataNotEmpty.getName());
            }
            if (surname != null && surname.isEmpty()) {
                postalDataNotEmpty.setSurname(surname);
                model.addAttribute("surname", postalDataNotEmpty.getSurname());
            }
            if (postalIndex != null && postalIndex.isEmpty()) {
                postalDataNotEmpty.setPostalIndex(postalIndex);
                model.addAttribute("postalIndex", postalDataNotEmpty.getPostalIndex());
            }
            if (city != null && city.isEmpty()) {
                postalDataNotEmpty.setCity(city);
                model.addAttribute("city", postalDataNotEmpty.getCity());
            }
            if (phoneNumber != null && phoneNumber.isEmpty()) {
                postalDataNotEmpty.setPhoneNumber(phoneNumber);
                model.addAttribute("phoneNumber", postalDataNotEmpty.getPhoneNumber());
            }
            if (street != null && street.isEmpty()) {
                postalDataNotEmpty.setStreet(street);
                model.addAttribute("street", postalDataNotEmpty.getStreet());
            }
            if (houseNumber != null && houseNumber.isEmpty()) {
                postalDataNotEmpty.setHouseNumber(houseNumber);
                model.addAttribute("houseNumber", postalDataNotEmpty.getHouseNumber());
                log.info("Фамилия" + lastName);
                log.info("Имя" + name);
                log.info("отчество" + surname);
                log.info("номер" + postalDataNotEmpty.getPhoneNumber());
                log.info("индекс" + postalIndex);
                log.info("город" + city);
                log.info("улица" + postalDataNotEmpty.getStreet());
                log.info("номер дома" + postalDataNotEmpty.getHouseNumber());
            }
            model.addAttribute("cart", cartUtil.getCart(request, response));
            return referer(request, response);
        }
        if (emptyFields.isEmpty()) {
            PostalData postalData = new PostalData(lastName, name, surname, phoneNumber, postalIndex, city, street, houseNumber);
            log.info("Фамилия" + lastName);
            log.info("Имя" + name);
            log.info("отчество" + surname);
            log.info("номер" + phoneNumber);
            log.info("индекс" + postalIndex);
            log.info("город" + city);
            log.info("улица" + street);
            log.info("номер дома" + houseNumber);
            orderService.save(order, principal, request, response, postalData);
            redirectAttributes.addFlashAttribute("message", "Заказ успешно сохранен");
        }
        return "redirect:/order";
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




}
