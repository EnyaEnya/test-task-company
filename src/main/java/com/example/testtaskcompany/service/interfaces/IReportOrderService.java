package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.dto.report.filter.OrderReportFilter;

public interface IReportOrderService {

    PageDto<OrderDto> getOrders(OrderReportFilter request);
}
