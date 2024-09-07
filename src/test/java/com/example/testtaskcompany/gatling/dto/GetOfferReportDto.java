package com.example.testtaskcompany.gatling.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GetOfferReportDto extends GetReportDto {

    private String materialTitle;
    private long providerId;

}
