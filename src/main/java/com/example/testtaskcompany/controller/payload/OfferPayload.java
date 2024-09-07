package com.example.testtaskcompany.controller.payload;

public record OfferPayload(Long materialId,
                           Integer quantity,
                           Long companyId,
                           Long providerId) {
}
