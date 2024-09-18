package com.example.testtaskcompany.service;

import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.entities.*;
import com.example.testtaskcompany.repository.*;
import com.example.testtaskcompany.service.interfaces.IManageOrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.dao.CannotAcquireLockException;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.example.testtaskcompany.service.ManageOfferServiceImpl.LOCK;

@Service
@RequiredArgsConstructor
@Slf4j
public class ManageOrderServiceImpl implements IManageOrderService {

    private final OrderRepository orderRepository;
    private final CompanyRepository companyRepository;
    private final ProductRepository productRepository;
    private final CompanyMaterialStoreRepository companyMaterialStoreRepository;
    private final ProductMaterialRepository productMaterialRepository;
    private final ClientRepository clientRepository;
    private final PlatformTransactionManager txManager;

    @Override
    @Transactional
    @CacheEvict(allEntries = true, cacheNames = "orders")
    public Order createOrder(long productId, int quantity, long companyId) {
        Order order = new Order();
        order.setClient(clientRepository.getReferenceById(1L)); //todo get from security context
        order.setCompany(companyRepository.getReferenceById(companyId));
        order.setProduct(productRepository.getReferenceById(productId));
        order.setQuantity(quantity);
        order.setCreatedAt(Instant.now());
        order.setTotalPrice(processOrderPrice(order));
        order.setStatus(isEnoughMaterialOnStore(order) ? Status.APPROVED : Status.REJECTED);

        return orderRepository.save(order);
    }

    @Override
    @Retryable(retryFor = {CannotAcquireLockException.class})
    @CacheEvict(allEntries = true, cacheNames = "orders")
    public OrderDto processOrder(Order outOrder) {

        TransactionTemplate txTemplate = new TransactionTemplate(txManager);
        txTemplate.setIsolationLevel(TransactionDefinition.ISOLATION_SERIALIZABLE);

        synchronized (LOCK) {
            return txTemplate.execute(state -> {

                Order order = orderRepository.getReferenceById(outOrder.getId());

                if (orderRepository.checkOrderApprovedAndUnprocessed(order.getId())
                        && isEnoughMaterialOnStore(order)) {

                    findRequiredMaterials(order).forEach(productMaterial -> {
                        Material material = productMaterial.getMaterial();
                        CompanyMaterialStore companyMaterialStore = companyMaterialStoreRepository
                                .findMaterialsOnStoreByMaterialIdAndCompanyId(material.getId(), order.getCompany().getId());

                        int currentQuantity = companyMaterialStore.getQuantity();
                        companyMaterialStore.setQuantity(currentQuantity - (productMaterial.getMaterialQuantity() * order.getQuantity()));
                        companyMaterialStoreRepository.save(companyMaterialStore);

                        log.info("orderId: {} orderMaterial: {} Material old quantity on store: {} Material new quantity on store: {}",
                                order.getId(), material.getTitle(), currentQuantity, companyMaterialStore.getQuantity());
                    });

                    Company company = order.getCompany();
                    BigDecimal currentCompanyFinancial = company.getFinancialAccount();
                    company.setFinancialAccount(currentCompanyFinancial.add(order.getTotalPrice()));

                    companyRepository.save(company);

                    log.info("orderId: {} orderPrice: {} Company old financial: {} Company new financial: {}",
                            order.getId(), order.getTotalPrice(), currentCompanyFinancial, company.getFinancialAccount());
                } else {
                    order.setStatus(Status.REJECTED);
                }
                order.setProcessed(true);
                orderRepository.save(order);
                return toDto(order);
            });
        }
    }

    private BigDecimal processOrderPrice(Order order) {

        return findRequiredMaterials(order).stream().map(productMaterial ->
                        BigDecimal.valueOf(productMaterial.getMaterialQuantity())
                                .multiply(productMaterial.getMaterial().getPrice())
                                .multiply(BigDecimal.valueOf(order.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

    }

    private boolean isEnoughMaterialOnStore(Order order) {
        Map<Long, Integer> materialsMap = new HashMap<>(); //Map<MaterialId, AllOrderMaterialQuantity>

        findRequiredMaterials(order).forEach(productMaterial -> materialsMap.put(productMaterial.getMaterial().getId(),
                productMaterial.getMaterialQuantity() * order.getQuantity()));

        boolean isEnough = false;

        for (Map.Entry<Long, Integer> entry : materialsMap.entrySet()) {
            if (companyMaterialStoreRepository.findMaterialsOnStoreWithQuantityAndCompanyId(entry.getKey(), entry.getValue(),
                    order.getCompany().getId()) == null) {
                isEnough = false;
                break;
            }
            isEnough = true;
        }
        return isEnough;
    }

    private List<ProductMaterial> findRequiredMaterials(Order order) {
        return productMaterialRepository.findMaterialsByProductId(order.getProduct().getId());
    }

    protected OrderDto toDto(Order order) {
        return new OrderDto(
                order.getId(),
                order.getClient().getUsername(),
                order.getProduct().getTitle(),
                order.getQuantity(),
                order.getCompany().getId(),
                order.getTotalPrice(),
                order.getStatus(),
                order.isProcessed(),
                order.getCreatedAt()
        );
    }
}
