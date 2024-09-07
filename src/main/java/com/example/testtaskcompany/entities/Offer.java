package com.example.testtaskcompany.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.JdbcType;
import org.hibernate.dialect.PostgreSQLEnumJdbcType;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Getter
@Setter
@Table(schema = "public", name = "offer")
@Slf4j
public class Offer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "material_id")
    private Material material;

    @Enumerated
    @JdbcType(PostgreSQLEnumJdbcType.class)
    private Status status;

    private Integer quantity;

    @ManyToOne
    @JoinColumn(name = "provider_id")
    private Provider provider;

    @ManyToOne
    @JoinColumn(name = "company_id")
    private Company company;

    private boolean processed;
    private BigDecimal totalPrice;
    private Instant createdAt;

}
