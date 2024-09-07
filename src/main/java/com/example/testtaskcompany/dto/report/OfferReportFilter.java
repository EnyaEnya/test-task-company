package com.example.testtaskcompany.dto.report;

import com.example.testtaskcompany.entities.Status;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@EqualsAndHashCode(callSuper = true)
public class OfferReportFilter extends CommonFilter {

    private Status status;

    private String materialTitle;

    private Long companyId;

    private Long providerId;

    private Instant createdFrom;

    private Instant createdTo;

}
