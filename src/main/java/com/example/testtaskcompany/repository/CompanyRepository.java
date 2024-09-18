package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.Company;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface CompanyRepository  extends JpaRepository<Company, Long>, JpaSpecificationExecutor<Company> {

}
