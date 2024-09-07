package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.entities.Order;

public interface IManageOrderService {

    Order createOrder(Long productId, Integer quantity, Long companyId);

    OrderDto processOrder(Order order);

}
