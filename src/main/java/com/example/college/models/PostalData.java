package com.example.college.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostalData {

    private String lastName;
    private String name;
    private String surname;
    private String phoneNumber;

    private String postalIndex;
    private String city;
    private String street;
    private String houseNumber;

}
