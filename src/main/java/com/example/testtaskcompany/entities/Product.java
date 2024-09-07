package com.example.testtaskcompany.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Entity
@Getter
@Setter
@Table(schema = "public", name = "product")
public class Product {

    @Id
    private Long id;

    private String title;

}
