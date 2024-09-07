package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.Provider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProviderRepository  extends JpaRepository<Provider, Long> {

}
