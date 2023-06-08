package com.example.college.repositories;

import com.example.college.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {

    Order findOrderByUuid(String uuid);

}
