package com.upc.sqa.springAPI.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {

    @RequestMapping("/greet")
    public String greet() {
        return "Greetings!";
    }
}

