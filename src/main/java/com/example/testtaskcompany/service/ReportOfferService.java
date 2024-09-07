package com.example.testtaskcompany.service;

import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.dto.report.OfferReportFilter;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.entities.*;
import com.example.testtaskcompany.entities.Company_;
import com.example.testtaskcompany.entities.Material_;
import com.example.testtaskcompany.entities.Offer_;
import com.example.testtaskcompany.entities.Provider_;
import com.example.testtaskcompany.repository.OfferRepository;
import com.example.testtaskcompany.service.interfaces.IReportOfferService;
import com.example.testtaskcompany.utils.Specifications;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ReportOfferService implements IReportOfferService, Specifications<Offer> {

    private final OfferRepository offerRepository;

    @Override
    @Transactional
    @Cacheable("offers")
    public PageDto<OfferDto> getOffers(OfferReportFilter request) {
        Pageable pageable = org.springframework.data.domain.PageRequest.of(request.getPageNumber(), request.getPageSize(), request.getSort());
        Specification<Offer> specification = equal(Offer_.status, request.getStatus())
                .and(equal(root -> root.get(Offer_.company).get(Company_.id), request.getCompanyId()))
                .and(equal(root -> root.get(Offer_.provider).get(Provider_.id), request.getProviderId()))
                .and(like(root -> root.get(Offer_.material).get(Material_.title), request.getMaterialTitle()))
                .and(ge(Offer_.createdAt, request.getCreatedFrom())
                        .and(le(Offer_.createdAt, request.getCreatedTo())));
        return PageDto.of(offerRepository.findAll(specification, pageable).map(this::toDto));
    }

    protected OfferDto toDto(Offer offer) {
        return new OfferDto(
                offer.getId(),
                offer.getCreatedAt(),
                offer.getTotalPrice(),
                offer.isProcessed(),
                offer.getProvider().getId(),
                offer.getCompany().getId(),
                offer.getQuantity(),
                offer.getStatus(),
                offer.getMaterial().getTitle()
        );
    }
}
