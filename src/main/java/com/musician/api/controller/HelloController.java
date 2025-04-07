package com.musician.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/auth/hello")
    public String hello() {
        return "Hello from Spring boot!";
    }
}