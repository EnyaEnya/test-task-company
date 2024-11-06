package com.example.testtaskcompany.controller;

import com.example.testtaskcompany.controller.payload.UserPayload;
import com.example.testtaskcompany.service.interfaces.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("user")
public class UserController {

    private final IUserService keycloakService;

    @PostMapping("/create")
    public void manageOrder(@RequestBody UserPayload payload) {
        keycloakService.manageUser(payload);
    }

}
