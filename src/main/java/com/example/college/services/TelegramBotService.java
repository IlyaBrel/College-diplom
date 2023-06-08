package com.example.college.services;

import com.example.college.models.Order;
import com.example.college.models.TelegramUser;
import com.example.college.models.User;
import com.example.college.models.enums.Status;
import com.example.college.repositories.TelegramUserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Hibernate;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.InlineKeyboardMarkup;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.InlineKeyboardButton;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

import java.util.ArrayList;
import java.util.List;

@Component

@Slf4j
@RequiredArgsConstructor
public class TelegramBotService extends TelegramLongPollingBot {
    private final UserService userService;
    private final TelegramUserRepository telegramUserRepository;

    private final OrderService orderService;

    List<Long> ch = new ArrayList<>();


    public boolean sendingMessageToTgUsers(String messageText) {
        List<TelegramUser> telegramUsers = telegramUserRepository.findByChatIdIsNotNull();
        for (TelegramUser telegramUser : telegramUsers) {
            Long chatId = telegramUser.getChatId();
            createMessages(chatId, messageText);
        }
        return true;
    }

    public void createMessages(Long chatId, String messageText) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(chatId.toString());
        sendMessage.setText(messageText);
        try {
            execute(sendMessage);
        } catch (TelegramApiException e) {
            e.printStackTrace();
        }
    }

    public void createMessagesOrder(Update update, Long chatId, Order order) {
        SendMessage sendMessage1 = new SendMessage();
        String uuid = order.getUuid();
        String s = String.valueOf(Status.ОТМЕНЁН);
        sendMessage1.setChatId(chatId.toString());
        sendMessage1.setText("Ваш заказ сформирован и отправлен в обработку." + "\n" + "Номер заказа:" +order.getId());
        InlineKeyboardMarkup inlineKeyboardMarkup1 = new InlineKeyboardMarkup();
        InlineKeyboardButton inlineKeyboardButton1 = new InlineKeyboardButton();
        inlineKeyboardButton1.setText("Отменить заказ");
        inlineKeyboardButton1.setCallbackData(uuid); // Callback data to identify the button press
        List<InlineKeyboardButton> keyboardButtonsRow1 = new ArrayList<>();
        keyboardButtonsRow1.add(inlineKeyboardButton1);
        List<List<InlineKeyboardButton>> rowList = new ArrayList<>();
        rowList.add(keyboardButtonsRow1);
        inlineKeyboardMarkup1.setKeyboard(rowList);
        sendMessage1.setReplyMarkup(inlineKeyboardMarkup1);
        try {
            execute(sendMessage1);
        } catch (TelegramApiException e) {
            e.printStackTrace();
        }
    }


    @Override
    public String getBotUsername() {
        return "your_bot_username";
    }

    @Override
    public String getBotToken() {
        return "6197283733:AAErqAVz55PxmQfKPxyZAi7euNfCK4mVuGs";
    }

    @Override
    public void onUpdateReceived(org.telegram.telegrambots.meta.api.objects.Update update) {
        if (update.hasMessage() && update.getMessage().hasText()) {
            String messageText = update.getMessage().getText();
            Long chatId = update.getMessage().getChatId();
            log.info("Фамилия" + update.getMessage().getChat().getFirstName());
            log.info("Чат id:" + chatId);
            ch.add(chatId);
            if ("/start".equals(messageText)) {
                if (userService.getByChatId(chatId) == null) {
                    TelegramUser telegramUser = new TelegramUser();
                    telegramUser.setChatId(ch.get(0));
                    telegramUser.setUserName(update.getMessage().getChat().getUserName());
                    telegramUser.setFirstName(update.getMessage().getChat().getFirstName());
                    telegramUser.setLastName(update.getMessage().getChat().getLastName());
                    userService.createTelegramUser(telegramUser);
                }
                SendMessage sendMessage = new SendMessage();
                sendMessage.setChatId(chatId.toString());
                sendMessage.setText("Привет! Нажми на кнопку чтобы получить ключ!");
                // Создание кнопки с ссылкой на веб-приложение
                InlineKeyboardMarkup inlineKeyboardMarkup = new InlineKeyboardMarkup();
                InlineKeyboardButton inlineKeyboardButton1 = new InlineKeyboardButton();
                inlineKeyboardButton1.setText("Жми!");
                inlineKeyboardButton1.setCallbackData("button_pressed"); // Callback data to identify the button press
                List<InlineKeyboardButton> keyboardButtonsRow1 = new ArrayList<>();
                keyboardButtonsRow1.add(inlineKeyboardButton1);
                List<List<InlineKeyboardButton>> rowList = new ArrayList<>();
                rowList.add(keyboardButtonsRow1);
                inlineKeyboardMarkup.setKeyboard(rowList);
                sendMessage.setReplyMarkup(inlineKeyboardMarkup);
                try {
                    execute(sendMessage);
                } catch (TelegramApiException e) {
                    e.printStackTrace();
                }
            }
        } else if (update.hasCallbackQuery()) {
            TelegramUser telegramUser = new TelegramUser();
            String callbackData = update.getCallbackQuery().getData();
            Long chatId = update.getCallbackQuery().getMessage().getChatId();
            if ("button_pressed".equals(callbackData)) {
                SendMessage sendMessage = new SendMessage();
                sendMessage.setChatId(chatId.toString());
                if (userService.getByChatId(chatId) == null) {
                    telegramUser.setChatId(ch.get(0));
                    telegramUser.setUserName(update.getMessage().getChat().getUserName());
                    telegramUser.setFirstName(update.getMessage().getChat().getFirstName());
                    telegramUser.setLastName(update.getMessage().getChat().getLastName());
                    userService.createTelegramUser(telegramUser);
                    sendMessage.setText(telegramUser.getCode());
                } else {
                    sendMessage.setText(userService.getByChatId(chatId).getCode());
                }
                try {
                    execute(sendMessage);
                } catch (TelegramApiException e) {
                    e.printStackTrace();
                }
            }
            if (orderService.findByUuid(callbackData) != null) {
                String dt =callbackData;
                log.info(dt);
                User user = userService.getById(orderService.findByUuid(dt).getUser().getId());
                log.info("Chat id: " + user.getTelegramUser().getChatId());
                SendMessage sendMessage = new SendMessage();
                sendMessage.setChatId(user.getTelegramUser().getChatId());
                sendMessage.setText("Вы отменили заказ!");
                orderService.updateByUuid(dt);
                try {
                    execute(sendMessage);
                } catch (TelegramApiException e) {
                    e.printStackTrace();
                }
            }
        }

    }
}