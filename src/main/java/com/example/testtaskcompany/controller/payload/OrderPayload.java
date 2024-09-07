package com.example.testtaskcompany.controller.payload;

public record OrderPayload(
        Long productId,
        Integer quantity,
        Long companyId) {
}
