package com.example.testtaskcompany.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcType;
import org.hibernate.dialect.PostgreSQLEnumJdbcType;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(schema = "public", name = "order_table")
public class Order extends AbstractIdEntity{

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false, name = "client_id")
    private Client client;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false, name = "product_id")
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "company_id")
    private Company company;

    private int quantity;
    private BigDecimal totalPrice;

    @Enumerated
    @JdbcType(PostgreSQLEnumJdbcType.class)
    private Status status;

    private boolean processed;

    private Instant createdAt;
}
