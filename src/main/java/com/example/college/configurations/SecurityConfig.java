package com.example.college.configurations;


import com.example.college.services.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private final CustomUserDetailsService userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http .csrf()
                .ignoringAntMatchers( "/login/activate/*") // Укажите URL, на котором нужно отключить CSRF-защиту
                .and()
                .authorizeRequests()
                .antMatchers("/","/home/**", "/products/**", "/images/**", "/logout/**", "/registration", "/user/**","/filter/**",
                        "/products/filter/add","/product/**",
                        "/static/css/style.css","/static/css/nikeImg.png", "/category/**","/products" , "/order/*",
                        "/home/**","/static/css/**", "/static/css/product-info-css.css",
                        "/product/create","/dimensions", "/favicon.ico", "/cart/**",
                        "https://i.ibb.co/brq1tJj/shopping-cart.png", "/filter/**","/logout"
                        )
                .permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .permitAll()
                .and()
                .logout()
                .permitAll();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(8);
    }
}
