package com.example.college.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tg_users")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TelegramUser {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name = "id")
        private Long id;
        @Column(name = "chat_id")
        private Long chatId;
        @Column(name = "user_name")
        private String userName;
        @Column(name = "last_name")
        private String lastName;
        @Column(name = "first_name")
        private String firstName;
        @Column(name = "code")
        private String code;
}
