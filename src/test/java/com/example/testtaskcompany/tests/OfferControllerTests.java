package com.example.testtaskcompany.tests;

import com.example.testtaskcompany.TestTaskCompanyApplication;
import com.example.testtaskcompany.dto.OfferDto;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.dto.report.filter.OfferReportFilter;
import com.example.testtaskcompany.entities.Company;
import com.example.testtaskcompany.entities.Offer;
import com.example.testtaskcompany.entities.Status;
import com.example.testtaskcompany.repository.CompanyRepository;
import com.example.testtaskcompany.repository.OfferRepository;
import com.example.testtaskcompany.service.interfaces.IManageOfferService;
import com.example.testtaskcompany.service.interfaces.IReportOfferService;
import com.example.testtaskcompany.service.interfaces.IUserService;
import groovy.util.logging.Slf4j;
import org.hibernate.Hibernate;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.support.TransactionTemplate;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@SpringBootTest(classes = {TestSecurityConfig.class, TestTaskCompanyApplication.class})
@RunWith(SpringRunner.class)
@Testcontainers
@Slf4j
public class OfferControllerTests {

    private static final Logger log = LoggerFactory.getLogger(OfferControllerTests.class);

    @MockBean
    private IUserService userService;

    @Autowired
    private IManageOfferService manageOfferService;

    @Autowired
    private IReportOfferService reportOfferService;

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private OfferRepository offerRepository;

    @Autowired
    private TransactionTemplate transactionTemplate;


    @Test
    public void testOfferCreationAndReport() throws ExecutionException, InterruptedException {
        CompletableFuture<Void> t1 = CompletableFuture.runAsync(() ->
                manageOfferService.processOffer(manageOfferService.createOffer(1L, 2, 1L, 1L)));
        CompletableFuture<Void> t2 = CompletableFuture.runAsync(() ->
                manageOfferService.processOffer(manageOfferService.createOffer(1L, 3, 1L, 1L)));
        CompletableFuture<Void> t3 = CompletableFuture.runAsync(() ->
                manageOfferService.processOffer(manageOfferService.createOffer(1L, 10, 1L, 1L)));
        CompletableFuture<Void> t4 = CompletableFuture.runAsync(() ->
                manageOfferService.processOffer(manageOfferService.createOffer(1L, 8, 1L, 1L)));
        t1.get();
        t2.get();
        t3.get();
        t4.get();

        transactionTemplate.executeWithoutResult(status -> {
            List<Offer> offers = offerRepository.findAll();
            offers.forEach(offer -> {
                log.info("offerId: " + offer.getId() + " offerStatus: " +
                        offer.getStatus() + " totalPrice: " + offer.getTotalPrice()
                        + " offerProcessed: " + offer.isProcessed());
            });
            Company company = Hibernate.unproxy(companyRepository.getReferenceById(1L), Company.class);
            log.info("Result company financial: " + company.getFinancialAccount());
        });

        OfferReportFilter request = new OfferReportFilter();
        request.setColumn("id");
        request.setDirection(Sort.Direction.ASC);
        request.setCompanyId(1L);
        request.setProviderId(1L);
        request.setPageNumber(0);
        request.setPageSize(50);
        request.setStatus(Status.APPROVED);

        PageDto<OfferDto> offers = reportOfferService.getOffers(request);

        Assert.assertFalse(offers.getContent().isEmpty());
    }
}