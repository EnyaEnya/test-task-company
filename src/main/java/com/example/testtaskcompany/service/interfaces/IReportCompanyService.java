package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.report.CompanyInfoDto;
import com.example.testtaskcompany.dto.report.CompanyReportFilter;

public interface IReportCompanyService {

    CompanyInfoDto getCompanyInfo(CompanyReportFilter request);
}
