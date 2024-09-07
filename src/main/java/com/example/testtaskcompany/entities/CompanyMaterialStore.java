package com.example.testtaskcompany.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(schema = "public", name = "company_material_store")
public class CompanyMaterialStore {

    @Id
    private Long id;

    @ManyToOne
    @JoinColumn(name = "material_id")
    private Material material;

    @ManyToOne
    @JoinColumn(name = "company_id")
    private Company company;

    private Integer quantity;


}
