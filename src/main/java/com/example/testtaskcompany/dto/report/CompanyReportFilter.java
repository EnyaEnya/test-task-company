package com.example.testtaskcompany.dto.report;


import com.example.testtaskcompany.dto.report.filter.CommonFilter;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(callSuper = true)
public class CompanyReportFilter extends CommonFilter {

    private long companyId;
}
