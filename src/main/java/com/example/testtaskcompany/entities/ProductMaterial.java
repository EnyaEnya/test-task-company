package com.example.testtaskcompany.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(schema = "public", name = "product_material")
public class ProductMaterial {

    @Id
    private Long id;

    @ManyToOne
    @JoinColumn(name="product_id")
    private Product product;

    @ManyToOne
    @JoinColumn(name="material_id")
    private Material material;

    private Integer materialQuantity;

}
