package com.example.testtaskcompany.dto;

import com.example.testtaskcompany.entities.Status;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
public class OfferDto {

    private Long id;
    private String materialTitle;
    private Status status;
    private Integer quantity;
    private Long companyId;
    private Long providerId;
    private boolean processed;
    private BigDecimal totalPrice;
    private Instant createdAt;


    public OfferDto(Long id, Instant createdAt, BigDecimal totalPrice,
                    boolean processed, Long providerId, Long companyId,
                    Integer quantity, Status status, String materialTitle) {
        this.id = id;
        this.createdAt = createdAt;
        this.totalPrice = totalPrice;
        this.processed = processed;
        this.providerId = providerId;
        this.companyId = companyId;
        this.quantity = quantity;
        this.status = status;
        this.materialTitle = materialTitle;
    }
}
