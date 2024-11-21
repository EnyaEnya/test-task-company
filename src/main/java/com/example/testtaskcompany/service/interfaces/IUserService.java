package com.example.testtaskcompany.service.interfaces;

import com.example.testtaskcompany.controller.payload.UserPayload;
import org.springframework.security.core.Authentication;

public interface IUserService {

    void manageUser(UserPayload payload);

    Authentication getAuthentication();

}
