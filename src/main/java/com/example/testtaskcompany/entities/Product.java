package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity
@Table(schema = "public", name = "product")
public class Product extends AbstractIdEntity {

    private String title;
}
