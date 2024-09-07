package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.dto.report.OfferReportFilter;
import com.example.testtaskcompany.dto.report.PageDto;

public interface IReportOfferService {

    PageDto<OfferDto> getOffers(OfferReportFilter request);

}
