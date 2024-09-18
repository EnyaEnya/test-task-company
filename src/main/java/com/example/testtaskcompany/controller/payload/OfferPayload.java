package com.example.testtaskcompany.controller.payload;

public record OfferPayload(
        long materialId,
        int quantity,
        long companyId,
        long providerId) {
}
