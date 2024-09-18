package com.example.testtaskcompany.gatling.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostOrderDto {

    private long productId;
    private int quantity;
    private String productTitle;
    private long companyId;

    public PostOrderDto(long productId, int quantity, String productTitle, long companyId) {
        this.productId = productId;
        this.quantity = quantity;
        this.productTitle = productTitle;
        this.companyId = companyId;
    }
}
