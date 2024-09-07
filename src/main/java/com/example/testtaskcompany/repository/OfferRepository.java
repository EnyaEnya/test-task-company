package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.Offer;
import com.example.testtaskcompany.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OfferRepository extends JpaRepository<Offer, Long>, JpaSpecificationExecutor<Offer> {

    @Query("select count(o) > 0 from Offer o where o.id = :offerId and o.processed = false and o.status = 'APPROVED'")
    boolean checkOfferApprovedAndUnprocessed(Long offerId);
}
