package com.example.testtaskcompany.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.NaturalId;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(schema = "public", name = "client")
public class Client extends AbstractIdEntity {

    @NaturalId
    private UUID keycloakId;

    private String username;

    private Instant createdAt;
}
