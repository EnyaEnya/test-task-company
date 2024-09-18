package com.example.testtaskcompany.gatling.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostOfferDto {

    private long materialId;
    private int quantity;
    private String materialTitle;
    private long companyId;
    private long providerId;
    private String units;

    public PostOfferDto(long materialId, int quantity, String materialTitle, long companyId, long providerId, String units) {
        this.materialId = materialId;
        this.quantity = quantity;
        this.materialTitle = materialTitle;
        this.companyId = companyId;
        this.providerId = providerId;
        this.units = units;
    }
}
