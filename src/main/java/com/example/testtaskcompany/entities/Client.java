package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Entity
@Getter
@Setter
@Table(schema = "public", name = "client")
public class Client {

    @Id
    private Long id;

    private String username;

    private Instant createdAt;
}
