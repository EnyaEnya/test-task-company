package com.example.testtaskcompany.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class MaterialDto {

    private Long id;
    private String title;
    private String units;
    private BigDecimal price;

    public MaterialDto(Long id, String title, String units, BigDecimal price) {
        this.id = id;
        this.title = title;
        this.units = units;
        this.price = price;
    }
}

