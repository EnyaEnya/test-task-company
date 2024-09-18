package com.example.testtaskcompany.dto.report;

import com.example.testtaskcompany.dto.report.json.MaterialStoreInfo;
import com.example.testtaskcompany.dto.report.json.ProductOrderInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class CompanyInfoDto {

    private long id;

    private String title;

    private BigDecimal financialAccount;

    private List<ProductOrderInfo> productOrderInfo;

    private BigDecimal approvedOrdersPercent;

    private List<MaterialStoreInfo> materialStoreInfo;
}
