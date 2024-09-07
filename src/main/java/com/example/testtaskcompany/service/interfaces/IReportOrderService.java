package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.dto.report.OrderReportFilter;
import com.example.testtaskcompany.dto.report.PageDto;

public interface IReportOrderService {

    PageDto<OrderDto> getOrders(OrderReportFilter request);
}
