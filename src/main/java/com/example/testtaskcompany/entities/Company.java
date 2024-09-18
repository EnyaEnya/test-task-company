package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(schema = "public", name = "company")
public class Company extends AbstractIdEntity {

    private String title;

    private BigDecimal financialAccount;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "company")
    private Set<CompanyMaterialStore> materialStoreSet;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "company")
    private Set<Offer> offersSet;
}
