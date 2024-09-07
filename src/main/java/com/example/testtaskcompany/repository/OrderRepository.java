package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    @Query("select count(o) > 0 from Order o where o.id = :orderId and o.processed = false and o.status = 'APPROVED'")
    boolean checkOrderApprovedAndUnprocessed(Long orderId);
}
