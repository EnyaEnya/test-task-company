package com.example.testtaskcompany.service;

import com.example.testtaskcompany.aop.Sync;
import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.entities.*;
import com.example.testtaskcompany.repository.*;
import com.example.testtaskcompany.service.interfaces.IManageOfferService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.dao.CannotAcquireLockException;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Instant;

import static org.springframework.transaction.annotation.Isolation.SERIALIZABLE;

@Service
@RequiredArgsConstructor
@Slf4j
public class ManageOfferServiceImpl implements IManageOfferService {

    private final OfferRepository offerRepository;
    private final MaterialRepository materialRepository;
    private final CompanyMaterialStoreRepository companyMaterialStoreRepository;
    private final CompanyRepository companyRepository;
    private final ProviderRepository providerRepository;


    @Override
    @Transactional
    @CacheEvict(allEntries = true, cacheNames = "offers")
    public Offer createOffer(long materialId, int quantity, long companyId, long providerId) {
        Offer offer = new Offer();
        offer.setMaterial(materialRepository.getReferenceById(materialId));
        offer.setCompany(companyRepository.getReferenceById(companyId));
        offer.setProvider(providerRepository.getReferenceById(providerId));
        offer.setQuantity(quantity);
        offer.setCreatedAt(Instant.now());
        offer.setTotalPrice(calculateOfferPrice(offer));
        determineOfferStatus(offer);

        return offerRepository.save(offer);
    }

    @Sync
    @Override
    @Transactional(isolation = SERIALIZABLE)
    @Retryable(retryFor = {CannotAcquireLockException.class})
    @CacheEvict(allEntries = true, cacheNames = "offers")
    public OfferDto processOffer(Offer offer) {

        offer = offerRepository.getReferenceById(offer.getId());

        Company company = offer.getCompany();

        if (offerRepository.checkOfferApprovedAndUnprocessed(offer.getId())
                && ((company.getFinancialAccount()
                .subtract(offer.getTotalPrice())
                .compareTo(BigDecimal.ZERO)) >= 0)) {

            CompanyMaterialStore materialOnStore = companyMaterialStoreRepository
                    .findMaterialsOnStoreByMaterialIdAndCompanyId(offer.getMaterial().getId(), offer.getCompany().getId());

            int currentQuantityOnStore = materialOnStore.getQuantity();
            materialOnStore.setQuantity(currentQuantityOnStore + offer.getQuantity());

            BigDecimal currentCompanyFinancial = company.getFinancialAccount();
            company.setFinancialAccount(currentCompanyFinancial.subtract(offer.getTotalPrice()));

            Provider provider = offer.getProvider();
            BigDecimal currentProviderFinancial = provider.getFinancialAccount();
            provider.setFinancialAccount(currentProviderFinancial.add(offer.getTotalPrice()));

            companyMaterialStoreRepository.save(materialOnStore);
            companyRepository.save(company);
            providerRepository.save(provider);

            log.info("offerId: {} offerPrice: {} Company old financial: {} Company new financial: {}",
                    offer.getId(), offer.getTotalPrice(), currentCompanyFinancial, company.getFinancialAccount());

        } else {
            offer.setStatus(Status.REJECTED);
        }
        offer.setProcessed(true);
        offerRepository.save(offer);
        return toDto(offer);
    }


    private BigDecimal calculateOfferPrice(Offer offer) {
        Material material = materialRepository.getReferenceById(offer.getMaterial().getId());
        return material.getPrice().multiply(BigDecimal.valueOf(offer.getQuantity()));
    }

    private void determineOfferStatus(Offer offer) {
        Company company = offer.getCompany();
        if ((company.getFinancialAccount().subtract(offer.getTotalPrice()).compareTo(BigDecimal.ZERO)) >= 0) {
            offer.setStatus(Status.APPROVED);
        } else {
            offer.setStatus(Status.REJECTED);
            offer.setProcessed(true);
        }

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
