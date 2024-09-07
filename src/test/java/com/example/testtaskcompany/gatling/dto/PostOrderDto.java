package com.example.testtaskcompany.gatling.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostOrderDto {

    private Long productId;
    private Integer quantity;
    private String productTitle;
    private Long companyId;

    public PostOrderDto(Long productId, Integer quantity, String productTitle, Long companyId) {
        this.productId = productId;
        this.quantity = quantity;
        this.productTitle = productTitle;
        this.companyId = companyId;
    }
}
