package com.example.testtaskcompany.entities.projections;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApprovedOrdersCountProjection {

    private long allOrders;
    private long approvedOrders;

    public ApprovedOrdersCountProjection(long allOrders, long approvedOrders) {
        this.allOrders = allOrders;
        this.approvedOrders = approvedOrders;
    }
}
