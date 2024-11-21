package com.example.testtaskcompany.service;

import com.example.testtaskcompany.controller.payload.UserPayload;
import com.example.testtaskcompany.entities.Client;
import com.example.testtaskcompany.repository.ClientRepository;
import com.example.testtaskcompany.service.interfaces.IUserService;
import jakarta.annotation.PostConstruct;
import jakarta.ws.rs.core.Response;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tika.utils.StringUtils;
import org.keycloak.admin.client.CreatedResponseUtil;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.OAuth2AuthorizationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@AllArgsConstructor
public class UserService implements IUserService {

    private final UsersResource usersResource;
    private final ClientRepository clientRepository;

    @Override
    public Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }


    //todo add two-phase commit
    @Override
    public void manageUser(UserPayload payload) {
        UserRepresentation keycloakUser = new UserRepresentation();
        keycloakUser.setUsername(payload.username());
        keycloakUser.setEmail(payload.email());
        keycloakUser.setEmailVerified(payload.isEmailVerified());
        keycloakUser.setFirstName(StringUtils.isEmpty(payload.firstName()) ? "null" : payload.firstName());
        keycloakUser.setLastName(StringUtils.isEmpty(payload.lastName()) ? "null" : payload.lastName());
        keycloakUser.setEnabled(!payload.isDeleted());

        if (payload.password() != null) {
            CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
            credentialRepresentation.setTemporary(false);
            credentialRepresentation.setType(CredentialRepresentation.PASSWORD);
            credentialRepresentation.setValue(payload.password());
            keycloakUser.setCredentials(List.of(credentialRepresentation));
        }


        log.info("add user {}", payload.email());
        try (Response response = usersResource.create(keycloakUser)) {
            log.info("response code {}", response.getStatus());
            if (response.getStatus() == Response.Status.CREATED.getStatusCode()) {
                String id = CreatedResponseUtil.getCreatedId(response);
                createLocalUser(payload.username(), UUID.fromString(id));
            }
            if (response.getStatus() != Response.Status.CREATED.getStatusCode() && response.getStatus() != Response.Status.OK.getStatusCode()) {
                throw new OAuth2AuthorizationException(new OAuth2Error("keycloak response code " + response.getStatus()));
            }
        }

    }


    public void createLocalUser(String userName, UUID keycloakId) {
        Client client = new Client();
        client.setUsername(userName);
        client.setKeycloakId(keycloakId);
        client.setCreatedAt(Instant.now());
        clientRepository.save(client);
    }

    public void deleteUser() {
    }

    @PostConstruct
    private void createFirstTestUser() {

        List<UserRepresentation> representations = usersResource.search("ivanov");

        if (representations.isEmpty()) {
            UserPayload userPayload = new UserPayload("ivanov", "ivanov.test@example.com",
                    true, "Ivan", "Ivanov",
                    true, "password", false);

            manageUser(userPayload);
        }
    }

}
