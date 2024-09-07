package com.example.testtaskcompany.gatling.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GetReportDto {

    private String column;
    private String direction;
    private String status;
    private int pageNumber;
    private int pageSize;
    private String createdTo;
    private String createdFrom;
    private long companyId;

}
