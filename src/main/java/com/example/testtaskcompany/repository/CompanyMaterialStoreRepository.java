package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.CompanyMaterialStore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompanyMaterialStoreRepository extends JpaRepository<com.example.testtaskcompany.entities.CompanyMaterialStore, Long> {

    @Query("select cm from CompanyMaterialStore cm where cm.company.id =:companyId and cm.material.id =:materialId and cm.quantity >= :quantity")
    com.example.testtaskcompany.entities.CompanyMaterialStore findMaterialsOnStoreWithQuantityAndCompanyId(Long materialId, Integer quantity, Long companyId);

    @Query("select cm from CompanyMaterialStore cm where cm.material.id =:materialId and cm.company.id =:companyId")
    com.example.testtaskcompany.entities.CompanyMaterialStore findMaterialsOnStoreByMaterialIdAndCompanyId(Long materialId, Long companyId);

    @Query("select cm from CompanyMaterialStore cm where cm.company.id =:companyId")
    List<com.example.testtaskcompany.entities.CompanyMaterialStore> findMaterialsOnStoreByCompanyId(Long companyId);

}
