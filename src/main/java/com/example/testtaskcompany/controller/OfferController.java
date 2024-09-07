package com.example.testtaskcompany.controller;

import com.example.testtaskcompany.controller.payload.OfferPayload;
import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.service.interfaces.IManageOfferService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("offer/materials")
public class OfferController {

    private final IManageOfferService manageOfferService;

    @PostMapping("/manage")
    public ResponseEntity<OfferDto> manageOffer(@RequestBody OfferPayload payload) {
        OfferDto offerDto = manageOfferService
                .processOffer(manageOfferService
                        .createOffer(payload.materialId(), payload.quantity(),
                                payload.companyId(), payload.providerId()));

        return ResponseEntity.ok(offerDto);
    }
}
