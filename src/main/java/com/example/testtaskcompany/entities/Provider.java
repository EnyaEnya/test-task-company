package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(schema = "public", name = "provider")
public class Provider extends AbstractIdEntity {

    private String title;

    private BigDecimal financialAccount;
}
