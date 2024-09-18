package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(schema = "public", name = "material")
public class Material extends AbstractIdEntity {

    private String title;

    private String units;

    private BigDecimal price;
}
