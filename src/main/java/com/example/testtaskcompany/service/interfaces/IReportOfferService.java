package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.dto.report.filter.OfferReportFilter;

public interface IReportOfferService {

    PageDto<OfferDto> getOffers(OfferReportFilter request);

}
