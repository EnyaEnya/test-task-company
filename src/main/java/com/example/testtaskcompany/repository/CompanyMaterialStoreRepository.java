package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.CompanyMaterialStore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompanyMaterialStoreRepository extends JpaRepository<CompanyMaterialStore, Long> {

    @Query("select cm from CompanyMaterialStore cm where cm.company.id =:companyId and cm.material.id =:materialId and cm.quantity >= :quantity")
    CompanyMaterialStore findMaterialsOnStoreWithQuantityAndCompanyId(long materialId, int quantity, long companyId);

    @Query("select cm from CompanyMaterialStore cm where cm.material.id =:materialId and cm.company.id =:companyId")
    CompanyMaterialStore findMaterialsOnStoreByMaterialIdAndCompanyId(long materialId, long companyId);

    @Query("select cm from CompanyMaterialStore cm where cm.company.id =:companyId")
    List<CompanyMaterialStore> findMaterialsOnStoreByCompanyId(long companyId);

}
