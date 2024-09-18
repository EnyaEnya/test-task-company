package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(schema = "public", name = "client")
public class Client extends AbstractIdEntity {

    private String username;

    private Instant createdAt;
}
