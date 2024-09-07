package com.example.testtaskcompany.controller;

import com.example.testtaskcompany.controller.payload.OrderPayload;
import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.service.interfaces.IManageOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("order/products")
public class OrderController {

    private final IManageOrderService defaultManageOrderService;

    @PostMapping("/manage")
    public ResponseEntity<OrderDto> manageOrder(@RequestBody OrderPayload payload) {
        OrderDto orderDto = defaultManageOrderService
                .processOrder(defaultManageOrderService
                        .createOrder(payload.productId(), payload.quantity(), payload.companyId()));

        return ResponseEntity.ok(orderDto);
    }

}
