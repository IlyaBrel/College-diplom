package com.example.college.services;


import com.example.college.models.TelegramUser;
import com.example.college.models.User;
import com.example.college.models.enums.Role;
import com.example.college.repositories.TelegramUserRepository;
import com.example.college.repositories.UserRepository;
import com.example.college.util.JavaMailSenderUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private final TelegramUserRepository telegramUserRepository;

    private final JavaMailSenderUtil javaMailSenderUtil;


    public User getById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);

        user.setActivationCode(UUID.randomUUID().toString());

        log.info("Saving new User with email: {}", email);
        userRepository.save(user);

        if (!StringUtils.isEmpty(user.getEmail())) {
            javaMailSenderUtil.messageToEmailAccount(user.getEmail(), "Подтверждение аккаунта", user.getEmail(), user.getName(), user.getActivationCode());
        }
        return true;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
                log.info("Ban user with id = {}; email: {}", user.getId(), user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unban user with id = {}; email: {}", user.getId(), user.getEmail());
            }
        }
        userRepository.save(user);
    }

    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        userRepository.save(user);
        return true;
    }

    public boolean updatePassword(Long id, String oldPassword, String twoOldPassword, String newPassword) {
        User user = userRepository.getById(id);
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            javaMailSenderUtil.messageToEmailPassword(user.getEmail(), "Обновление пароля", "ошибка при обновлении пароля", user.getName());
            return false;
        }
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        javaMailSenderUtil.messageToEmailPassword(user.getEmail(), "Обновление пароля", "пароль успешно обновлён", user.getName());
        return true;
    }

    public boolean activateUserMessage(Long id) {
        User user = userRepository.getById(id);
        if (user.getActivationCode() != null) {
            javaMailSenderUtil.messageToEmailAccount(user.getEmail(), "Подтверждение аккаунта", user.getEmail(), user.getName(), user.getActivationCode());
            return true;
        }
        return false;
    }

    public boolean createTelegramUser(TelegramUser userTg) {
        Long chatId = userTg.getChatId();
        if (telegramUserRepository.getByChatId(chatId) != null) return false;
        userTg.setCode(String.valueOf(UUID.randomUUID()));
        telegramUserRepository.save(userTg);
        return true;
    }

    public TelegramUser getByChatId(Long chatId) {
        return telegramUserRepository.getByChatId(chatId);
    }

    public boolean setTelegramUserToUser(Long id, String code) {
        TelegramUser telegramUser = telegramUserRepository.getTelegramUserByCode(code);
        if (telegramUser == null) return false;
        User user = getById(id);
        user.setTelegramUser(telegramUser);
        userRepository.save(user);
        return true;
    }




}
