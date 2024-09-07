package com.example.testtaskcompany.controller;


import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.dto.report.OfferReportFilter;
import com.example.testtaskcompany.dto.report.OrderReportFilter;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.service.interfaces.IReportOfferService;
import com.example.testtaskcompany.service.interfaces.IReportOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("report/info")
public class ReportController {

    private final IReportOfferService offerService;

    private final IReportOrderService orderService;

    @GetMapping("/offers")
    public PageDto<OfferDto> getOffersReportWithStatus(OfferReportFilter request) {
        return offerService.getOffers(request);
    }

    @GetMapping("/orders")
    public PageDto<OrderDto> getOrdersReport(OrderReportFilter request) {
        return orderService.getOrders(request);
    }

}
