package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.entities.Offer;

public interface IManageOfferService {

    Offer createOffer(long materialId, int quantity, long companyId, long providerId);

    OfferDto processOffer(Offer offer);
}
