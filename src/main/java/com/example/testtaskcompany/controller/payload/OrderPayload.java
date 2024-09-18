package com.example.testtaskcompany.controller.payload;

public record OrderPayload(
        long productId,
        int quantity,
        long companyId) {
}
