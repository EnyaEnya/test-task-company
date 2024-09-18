package com.example.testtaskcompany.dto.report.json;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ProductOrderInfo {

    private String productTitle;

    private long productQuantity;
}
