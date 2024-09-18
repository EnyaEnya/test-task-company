package com.example.testtaskcompany.dto.report.json;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class CompanyInfo {

    private List<ProductOrderInfo> productOrderInfoList;

    private StatOrderInfo statOrderInfo;

    private List<MaterialStoreInfo> materialStoreInfoList;
}
