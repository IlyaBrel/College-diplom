package com.example.college.repositories;

import com.example.college.models.TelegramUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TelegramUserRepository  extends JpaRepository<TelegramUser, Long> {

    TelegramUser getByChatId(Long chatId);
    TelegramUser getTelegramUserByCode(String code);

    List<TelegramUser> findByChatIdIsNotNull();
}
