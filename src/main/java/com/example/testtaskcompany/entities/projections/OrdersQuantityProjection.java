package com.example.testtaskcompany.entities.projections;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrdersQuantityProjection {

    private String productTitle;
    private long productQuantityOnOrders;


    public OrdersQuantityProjection(String productTitle, long productQuantityOnOrders) {
        this.productTitle = productTitle;
        this.productQuantityOnOrders = productQuantityOnOrders;
    }
}
