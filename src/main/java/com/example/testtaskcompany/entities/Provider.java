package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Getter
@Setter
@Table(schema = "public", name = "provider")
public class Provider {

    @Id
    private Long id;

    private String title;

    private BigDecimal financialAccount;

}
