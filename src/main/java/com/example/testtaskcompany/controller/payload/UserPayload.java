package com.example.testtaskcompany.controller.payload;

public record UserPayload(
        String username,
        String email,
        boolean isEmailVerified,
        String firstName,
        String lastName,
        boolean isEnabled,
        String password,
        boolean isDeleted
) {
}
