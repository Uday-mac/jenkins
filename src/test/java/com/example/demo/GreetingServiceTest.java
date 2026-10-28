package com.example.demo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class GreetingServiceTest {

    private final GreetingService greetingService =
            new GreetingService();

    @Test
    void shouldReturnGreeting() {
        String result = greetingService.getGreeting();

        assertEquals("Hello from Java Spring Boot!", result);
    }

    @Test
    void shouldReturnConsistentGreeting() {
        assertEquals(
            greetingService.getGreeting(),
            greetingService.getGreeting()
        );
    }
}
