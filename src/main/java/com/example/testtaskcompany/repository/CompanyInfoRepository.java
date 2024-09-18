package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.projections.ApprovedOrdersCountProjection;
import com.example.testtaskcompany.entities.projections.CompanyInfoProjectionEntity;
import com.example.testtaskcompany.entities.projections.MaterialsOnStoreProjection;
import com.example.testtaskcompany.entities.projections.OrdersQuantityProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompanyInfoRepository extends JpaRepository<CompanyInfoProjectionEntity, Long> {


    // get info with projection
    @Query("""
            select new com.example.testtaskcompany.entities.projections.OrdersQuantityProjection(
            p.title, sum(o.quantity)) from Order o
            join Product p on o.product.id = p.id where o.company.id = :companyId group by p.title""")
    List<OrdersQuantityProjection> getOrdersByCompanyId(long companyId);

    @Query("""
            select new com.example.testtaskcompany.entities.projections.MaterialsOnStoreProjection(
            m.title, cms.quantity) from Material m
            join CompanyMaterialStore cms on m.id = cms.material.id where cms.company.id = :companyId""")
    List<MaterialsOnStoreProjection> getMaterialsOnStoreByCompanyId(long companyId);

    @Query("""
        select new com.example.testtaskcompany.entities.projections.ApprovedOrdersCountProjection(
        count(*), count(*)) from Order o
        where o.company.id = :companyId""")
    List<ApprovedOrdersCountProjection> getCountsByCompanyId(long companyId);

}
