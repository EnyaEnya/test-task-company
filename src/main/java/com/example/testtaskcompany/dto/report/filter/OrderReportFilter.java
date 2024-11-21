package com.example.testtaskcompany.dto.report.filter;

import com.example.testtaskcompany.entities.Status;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@EqualsAndHashCode(callSuper = true)
public class OrderReportFilter extends CommonFilter {

    private Status status;

    private String productTitle;

    private Long companyId;

    private Instant createdFrom;

    private Instant createdTo;


}
