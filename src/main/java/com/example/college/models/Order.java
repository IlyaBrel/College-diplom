package com.example.college.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "orders")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @Embedded
    private PostalData postalData;

    @Column(name = "total_price")
    private int totalPrice;

    @ElementCollection
    @CollectionTable(name = "ordered_products", joinColumns = @JoinColumn(name = "order_id"))
    @MapKeyColumn(name = "product_id")
    @Column(name = "size")
    private Map<Long, String> productsIdAndSize = new HashMap<>();


    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    @JsonIgnore
    private User user;

    @Column(name = "order_status")
    private String status;

    private LocalDateTime deliveryDate;
    private LocalDateTime orderDate;


    private String uuid;

    @PrePersist
    private void init() {
        orderDate = LocalDateTime.now();
    }
}


