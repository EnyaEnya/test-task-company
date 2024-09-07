package com.example.testtaskcompany.gatling.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostOfferDto {

    private Long materialId;
    private Integer quantity;
    private String materialTitle;
    private Long companyId;
    private Long providerId;
    private String units;

    public PostOfferDto(Long materialId, Integer quantity, String materialTitle, Long companyId, Long providerId, String units) {
        this.materialId = materialId;
        this.quantity = quantity;
        this.materialTitle = materialTitle;
        this.companyId = companyId;
        this.providerId = providerId;
        this.units = units;
    }
}
