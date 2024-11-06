package com.example.testtaskcompany.repository;

import com.example.testtaskcompany.entities.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientRepository extends JpaRepository<Client, Long> {

    @Query("select c from Client c where c.username = :username")
    Client getClientByUsername(String username);

}
