package com.example.testtaskcompany.dto;

import com.example.testtaskcompany.entities.Status;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
public class OrderDto {

    private Long id;
    private String client;
    private String productTitle;
    private Integer quantity;
    private Long companyId;
    private BigDecimal totalPrice;
    private Status status;
    private boolean processed;
    private Instant createdAt;


    public OrderDto(Long id, String client, String productTitle, Integer quantity,
                    Long companyId, BigDecimal totalPrice, Status status, boolean processed, Instant createdAt) {
        this.id = id;
        this.client = client;
        this.productTitle = productTitle;
        this.quantity = quantity;
        this.companyId = companyId;
        this.totalPrice = totalPrice;
        this.status = status;
        this.processed = processed;
        this.createdAt = createdAt;
    }

}
