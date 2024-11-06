package com.example.testtaskcompany.config;

import jakarta.ws.rs.client.ClientBuilder;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.OAuth2Constants;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.UsersResource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.CsrfConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;

@Slf4j
@Configuration
public class SecurityBeans {

    @Value("${app.keycloak-properties.realm-name}")
    private String realmName;

    @Value("${app.keycloak-properties.client-id}")
    private String clientId;

    @Value("${app.keycloak-properties.client-secret}")
    private String clientSecret;

    @Bean
    public Keycloak keycloak(OAuth2ResourceServerProperties properties) {
        return KeycloakBuilder
                .builder()
                .serverUrl(getServerUrl(properties))
                .realm(realmName)
                .grantType(OAuth2Constants.CLIENT_CREDENTIALS)
                .clientId(clientId)
                .clientSecret(clientSecret)
                .resteasyClient(ClientBuilder.newClient())
                .build();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
                .sessionManagement(configurer -> configurer.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .csrf(CsrfConfigurer::disable)
                .oauth2ResourceServer(configurer -> configurer.jwt(jwt -> {
                    JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
                    jwtAuthenticationConverter.setPrincipalClaimName("preferred_username");
                    jwt.jwtAuthenticationConverter(jwtAuthenticationConverter);
                }))
                .build();
    }

    @Bean
    public UsersResource usersResource(Keycloak keycloak) {
        return keycloak.realm(realmName).users();
    }

    private String getServerUrl(OAuth2ResourceServerProperties properties) {
        return properties.getJwt().getIssuerUri().split("/realms/")[0];
    }
}
