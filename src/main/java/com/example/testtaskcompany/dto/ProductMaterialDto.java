package com.example.testtaskcompany.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
public class ProductMaterialDto {

    private String product;
    private Map<String, Integer> materialWithQuantity;

}
