package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.ProductMaterial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductMaterialRepository extends JpaRepository<ProductMaterial, Long> {

    @Query("select pm from ProductMaterial pm where pm.product.id = :productId")
    List<ProductMaterial> findMaterialsByProductId(Long productId);
}
