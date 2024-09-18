package com.example.testtaskcompany.service;

import com.example.testtaskcompany.dto.report.CompanyInfoDto;
import com.example.testtaskcompany.dto.report.CompanyReportFilter;
import com.example.testtaskcompany.entities.Company;
import com.example.testtaskcompany.entities.projections.CompanyInfoProjectionEntity;
import com.example.testtaskcompany.repository.CompanyInfoRepository;
import com.example.testtaskcompany.service.interfaces.IReportCompanyService;
import com.example.testtaskcompany.utils.Specifications;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportCompanyService implements IReportCompanyService, Specifications<Company> {

    private final CompanyInfoRepository companyInfoRepository;

    @Override
    @Transactional
    public CompanyInfoDto getCompanyInfo(CompanyReportFilter request) {

        CompanyInfoProjectionEntity companyInfo = companyInfoRepository.getReferenceById(request.getCompanyId());

        BigDecimal approvedOrdersPercent = BigDecimal.valueOf((
                companyInfo.getCompanyInfo().getStatOrderInfo().getApprovedOrders() * 100)
                / companyInfo.getCompanyInfo().getStatOrderInfo().getAllOrders())
                .setScale(2, RoundingMode.HALF_DOWN);

        return new CompanyInfoDto(companyInfo.getId(),
                    companyInfo.getTitle(),
                companyInfo.getFinancialAccount(),
                companyInfo.getCompanyInfo().getProductOrderInfoList(),
                approvedOrdersPercent,
                companyInfo.getCompanyInfo().getMaterialStoreInfoList()
        );
    }

}
