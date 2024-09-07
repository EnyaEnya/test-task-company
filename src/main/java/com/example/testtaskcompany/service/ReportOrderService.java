package com.example.testtaskcompany.service;

import com.example.testtaskcompany.dto.OrderDto;
import com.example.testtaskcompany.dto.report.OrderReportFilter;
import com.example.testtaskcompany.dto.report.PageDto;
import com.example.testtaskcompany.entities.Company_;
import com.example.testtaskcompany.entities.Order;
import com.example.testtaskcompany.entities.Order_;
import com.example.testtaskcompany.entities.Product_;
import com.example.testtaskcompany.repository.OrderRepository;
import com.example.testtaskcompany.service.interfaces.IReportOrderService;
import com.example.testtaskcompany.utils.Specifications;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ReportOrderService implements IReportOrderService, Specifications<Order> {

    private final OrderRepository orderRepository;

    @Override
    @Transactional
    @Cacheable("orders")
    public PageDto<OrderDto> getOrders(OrderReportFilter request) {
        Pageable pageable = org.springframework.data.domain.PageRequest.of(request.getPageNumber(), request.getPageSize(), request.getSort());
        Specification<Order> specification = equal(Order_.status, request.getStatus())
                .and(like(root -> root.get(Order_.product).get(Product_.title), request.getProductTitle()))
                .and(equal(root -> root.get(Order_.company).get(Company_.id), request.getCompanyId()))
//                .and(equal(root -> root.get(Order_.client).get(Client_.id), request.getClientId())) //todo get from security context
                .and(ge(Order_.createdAt, request.getCreatedFrom())
                        .and(le(Order_.createdAt, request.getCreatedTo())));
        return PageDto.of(orderRepository.findAll(specification, pageable).map(this::toOrderDto));
    }

    protected OrderDto toOrderDto(Order order) {
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
