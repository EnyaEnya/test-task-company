package com.example.testtaskcompany.tests;

import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.dto.report.OrderReportFilter;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.entities.*;
import com.example.testtaskcompany.repository.CompanyMaterialStoreRepository;
import com.example.testtaskcompany.repository.CompanyRepository;
import com.example.testtaskcompany.repository.OrderRepository;
import com.example.testtaskcompany.repository.ProductMaterialRepository;
import com.example.testtaskcompany.service.interfaces.IManageOrderService;
import com.example.testtaskcompany.service.interfaces.IReportOrderService;
import groovy.util.logging.Slf4j;
import org.hibernate.Hibernate;
import org.junit.Assert;
import org.junit.Test;
import org.junit.jupiter.api.BeforeAll;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.support.TransactionTemplate;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@SpringBootTest
@Testcontainers
@RunWith(SpringRunner.class)
@Slf4j
public class OrderControllerTests {

    private static final Logger log = LoggerFactory.getLogger(OrderControllerTests.class);

    @Autowired
    private IManageOrderService manageOrderService;

    @Autowired
    private IReportOrderService reportOrderService;

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private CompanyMaterialStoreRepository companyMaterialStoreRepository;

    @Autowired
    private ProductMaterialRepository productMaterialRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private TransactionTemplate transactionTemplate;

    @Test
    public void testOrderCreation() throws ExecutionException, InterruptedException {
        CompletableFuture<Void> t1 = CompletableFuture.runAsync(() ->
                manageOrderService.processOrder(manageOrderService.createOrder(1L, 1, 1L)));
        CompletableFuture<Void> t2 = CompletableFuture.runAsync(() ->
                manageOrderService.processOrder(manageOrderService.createOrder(1L, 2, 1L)));
        CompletableFuture<Void> t3 = CompletableFuture.runAsync(() ->
                manageOrderService.processOrder(manageOrderService.createOrder(1L, 10, 1L)));
        CompletableFuture<Void> t4 = CompletableFuture.runAsync(() ->
                manageOrderService.processOrder(manageOrderService.createOrder(1L, 8, 1L)));
        t1.get();
        t2.get();
        t3.get();
        t4.get();

        transactionTemplate.executeWithoutResult(status -> {
            List<Order> orders = orderRepository.findAll();
            orders.forEach(order -> {
                log.info("Order_id: {} Order_status: {} Total_price: {} Order_processed: {}",
                        order.getId(), order.getStatus(), order.getTotalPrice(), order.isProcessed());

                List<ProductMaterial> materials = productMaterialRepository.findMaterialsByProductId(order.getProduct().getId());
                materials.forEach(material -> {
                    CompanyMaterialStore companyMaterialStore = companyMaterialStoreRepository
                            .findMaterialsOnStoreByMaterialIdAndCompanyId(material.getId(), order.getCompany().getId());

                    log.info("Order_material_title: {} Material_quantity_on_store: {}",
                            material.getMaterial().getTitle(), companyMaterialStore.getQuantity());
                });

            });

            Company company = Hibernate.unproxy(companyRepository.getReferenceById(1L), Company.class);
            log.info("Order_result_company_financial: {}", company.getFinancialAccount());
        });
    }

    @Test
    public void testGetOrders() {

        OrderReportFilter request = new OrderReportFilter();
        request.setColumn("id");
        request.setDirection(Sort.Direction.ASC);
        request.setPageNumber(0);
        request.setPageSize(50);
        request.setStatus(Status.APPROVED);
        request.setCompanyId(1L);

        PageDto<OrderDto> orders = reportOrderService.getOrders(request);

        Assert.assertFalse(orders.getContent().isEmpty());
    }

}