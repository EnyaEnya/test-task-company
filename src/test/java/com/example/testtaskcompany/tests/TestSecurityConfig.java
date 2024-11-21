package com.example.testtaskcompany.tests;

import com.example.testtaskcompany.config.SecurityBeans;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.UsersResource;
import org.mockito.Mockito;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;

@MockBean(classes = {SecurityBeans.class})
@TestConfiguration
public class TestSecurityConfig {

    @Primary
    @Bean
    public Keycloak keycloakMock() {
        return Mockito.mock(Keycloak.class);
    }

    @Primary
    @Bean
    public UsersResource emailSender() {
        return Mockito.mock(UsersResource.class);
    }

}
