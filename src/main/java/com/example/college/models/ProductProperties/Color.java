package com.example.college.models.ProductProperties;

import com.example.college.models.Product;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "color")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "name")
    private String name;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "color")
    private List<Product> products = new ArrayList<>();

}