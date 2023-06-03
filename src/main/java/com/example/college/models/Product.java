package com.example.college.models;

import com.example.college.models.productProperties.Brand;
import com.example.college.models.productProperties.Color;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name = "products")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "title")
    private String title;
    @Column(name = "description", columnDefinition = "text")
    private String description;


    @Column(name = "price")
    private int price;
    @Column(name = "promotionalPrice")
    private int promotionalPrice;

    @Column(name = "city")
    private String city;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY,
            mappedBy = "product")
    private List<Image> images = new ArrayList<>();
    private Long previewImageId;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    @JsonIgnore
    private User user;
    @JsonIgnore
    private LocalDateTime dateOfCreated;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    private Category category;
    //Цены
    @Column(name = "active")
    private boolean popular;

    @ElementCollection
    @CollectionTable(name = "product_dimensions", joinColumns = @JoinColumn(name = "product_id"))
    @MapKeyColumn(name = "dimension")
    @Column(name = "quantity")
    private Map<String, Integer> dimensions = new HashMap<>();
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    private Brand brand;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    private Color color;

    @JsonIgnore
    private LocalDateTime lastUpdate;

    @PrePersist
    private void init() {
        dateOfCreated = LocalDateTime.now();
    }


    public void addImageToProduct(Image image) {
        image.setProduct(this);
        images.add(image);
    }


    public boolean isPopular() {
        return popular;
    }

    public boolean setPopular(boolean popular) {
        return this.popular = popular;
    }
}
