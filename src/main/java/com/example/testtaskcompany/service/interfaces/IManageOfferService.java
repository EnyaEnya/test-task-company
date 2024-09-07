package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.entities.Offer;

public interface IManageOfferService {

    Offer createOffer(Long materialId, Integer quantity, Long companyId, Long providerId);

    OfferDto processOffer(Offer offer);
}
