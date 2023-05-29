package com.example.college.util;

import com.example.college.models.Order;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.internet.MimeMessage;


@Component
@Slf4j
@RequiredArgsConstructor
public class JavaMailSenderUtil {

    private final JavaMailSender mailSender;

    public boolean messageToEmail(String userEmail, Order order, String messageTitle, String emailContent) {
        try {


            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            // Установка получателя, темы и текста письма
            helper.setTo(userEmail);
            helper.setSubject(messageTitle);


            // Создание содержимого письма с информацией о заказе
            emailContent = createOrderMailConten(order); // Здесь необходимо создать содержимое письма на основе данных заказа

            // Установка содержимого письма
            helper.setText(emailContent, true);

            // Отправка письма
            mailSender.send(message);
            log.info("Отправлено" + message.getContent());
            return true; // Успешно отправлено уведомление
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Ошибка при отправке уведомления
        }
    }

    public boolean messageToEmailAccount(String userEmail, String messageTitle, String emailContent, String user, String uuid) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            // Установка получателя, темы и текста письма
            helper.setTo(userEmail);
            helper.setSubject(messageTitle);

            // Создание содержимого письма с информацией о заказе
            emailContent = createAccount(user, uuid); // Здесь необходимо создать содержимое письма на основе данных заказа
            // Установка содержимого письма
            helper.setText(emailContent, true);
            // Отправка письма
            mailSender.send(message);
            log.info("Отправлено" + message.getContent());
            return true; // Успешно отправлено уведомление
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Ошибка при отправке уведомления
        }
    }


    public String createOrderMailConten(Order order) {
        StringBuilder contentBuilder = new StringBuilder();

        // Добавление информации о заказе в текст письма
        contentBuilder.append("Уважаемый пользователь,\n\n");
        contentBuilder.append("\n" +"Ваш заказ был успешно оформлен.\n\n");

        // Добавление деталей заказа
        contentBuilder.append("\n" +"Детали заказа:\n");
        contentBuilder.append("\n" +"Номер заказа: ").append(order.getId()).append("\n");
        contentBuilder.append("\n" +"Дата заказа: ").append("100").append("\n");
        contentBuilder.append("\n" +"Сумма заказа: ").append(order.getTotalPrice()).append("\n\n");

        // Добавление информации о доставке
        contentBuilder.append("\n" +"Информация о доставке:\n");
        contentBuilder.append("\n" +"ФИО: ").append(order.getPostalData().getLastName()).append(" ")
                .append(order.getPostalData().getName()).append(" ")
                .append(order.getPostalData().getSurname()).append("\n");
        contentBuilder.append("\n" +"Индекс: ").append(order.getPostalData().getPostalIndex()).append("\n");
        contentBuilder.append("\n" +"Город: ").append(order.getPostalData().getCity()).append("\n");
        contentBuilder.append("\n" +"Улица: " ).append(order.getPostalData().getStreet()).append("\n");
        contentBuilder.append("\n" +"Номер дома: ").append(order.getPostalData().getHouseNumber()).append("\n\n");

        contentBuilder.append("\n" +"Спасибо за ваш заказ!\n");

        return contentBuilder.toString();
    }

    public String createAccount(String user, String uuid) {
        StringBuilder contentBuilder = new StringBuilder();
        // Добавление информации о заказе в текст письма
        contentBuilder.append("Уважаемый " + user + ",\n подвтердите создание аккаунта перейдя по ссылке:");
        contentBuilder.append("http://localhost:8089/login/activate/" + uuid);
        return contentBuilder.toString();
    }


    public boolean messageToEmailPassword(String userEmail, String messageTitle, String messageOnEmail, String user) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            // Установка получателя, темы и текста письма
            helper.setTo(userEmail);
            helper.setSubject(messageTitle);

            // Создание содержимого письма с информацией о заказе
            String emailContent = updatePassword(user, messageOnEmail); // Здесь необходимо создать содержимое письма на основе данных заказа
            // Установка содержимого письма
            helper.setText(emailContent, true);
            // Отправка письма
            mailSender.send(message);
            log.info("Отправлено" + message.getContent());
            return true; // Успешно отправлено уведомление
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Ошибка при отправке уведомления
        }
    }

    public String updatePassword(String user, String message) {
        StringBuilder contentBuilder = new StringBuilder();
        // Добавление информации о заказе в текст письма
        contentBuilder.append("Уважаемый "+"\n" + user + ",\n" + message);
        return contentBuilder.toString();
    }


    public boolean contactFormMessage(String userEmail, String messageTitle, String name, String messageForm) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            // Установка получателя, темы и текста письма
            helper.setTo(userEmail);
            helper.setSubject(messageTitle);

            // Создание содержимого письма с информацией о заказе
            String emailContent = createContactFormMessageContent(name, messageForm); // Здесь необходимо создать содержимое письма на основе данных заказа

            // Установка содержимого письма
            helper.setText(emailContent, true);

            // Отправка письма
            mailSender.send(message);
            log.info("Отправлено" + message.getContent());
            return true; // Успешно отправлено уведомление
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Ошибка при отправке уведомления
        }
    }


    public String createContactFormMessageContent(String name, String message) {
        StringBuilder contentBuilder = new StringBuilder();

        // Добавление информации о заказе в текст письма
        contentBuilder.append("Уважаемый пользователь,\n\n"+"\n" + name);
        contentBuilder.append("Ваше обращение было успешно отправлено.\n\n" +"\n" );

        // Добавление деталей заказа
        contentBuilder.append("Детали обращения:\n" +"\n" + message);

        contentBuilder.append("Спасибо за ваше обращение! В скором времени вы получите ответ.\n");

        return contentBuilder.toString();
    }


    public boolean contactFormMessageAdmin(String userEmail, Long userID, String name, String messageForm) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            // Установка получателя, темы и текста письма
            helper.setTo("bellsellby@gmail.com");
            helper.setSubject("Обращение от пользователя");

            // Создание содержимого письма с информацией о заказе
            String emailContent = createContactFormMessageContentAdmin(userEmail,userID, name, messageForm); // Здесь необходимо создать содержимое письма на основе данных заказа

            // Установка содержимого письма
            helper.setText(emailContent, true);

            // Отправка письма
            mailSender.send(message);
            log.info("Отправлено" + message.getContent());
            return true; // Успешно отправлено уведомление
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Ошибка при отправке уведомления
        }
    }


    public String createContactFormMessageContentAdmin(String email, Long userId, String nameMessage, String message) {
        StringBuilder contentBuilder = new StringBuilder();

        // Добавление информации о заказе в текст письма
        contentBuilder.append("Пользователь,\n\n" + email);
        contentBuilder.append("обратился к администрации\n\n");
        contentBuilder.append("Имя пользователя который обратился:" + nameMessage);
        contentBuilder.append("Id пользователя который обратился:" + userId);

        // Добавление деталей заказа
        contentBuilder.append("Детали обращения:\n" + message);
        return contentBuilder.toString();
    }

}
