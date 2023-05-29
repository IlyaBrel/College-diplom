package com.example.college.models.enums;

import org.springframework.security.core.GrantedAuthority;

public enum Status implements GrantedAuthority {

    ОТМЕНЁН, ДОСТАВЛЕН, В_ОБРАБОТКЕ, В_ПРОЦЕССЕ_ДОСТАВКИ, ПРИНЯТ;

    @Override
    public String getAuthority() {
        return name();
    }
}
