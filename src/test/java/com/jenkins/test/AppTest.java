package com.jenkins.test;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for App class
 */
@DisplayName("App Tests")
public class AppTest {
    
    private App app;
    
    @BeforeEach
    public void setUp() {
        app = new App();
    }
    
    @Test
    @DisplayName("Test greeting with valid name")
    public void testGetGreetingWithName() {
        String result = app.getGreeting("Jenkins");
        assertEquals("Hello, Jenkins!", result);
    }
    
    @Test
    @DisplayName("Test greeting with null")
    public void testGetGreetingWithNull() {
        String result = app.getGreeting(null);
        assertEquals("Hello, World!", result);
    }
    
    @Test
    @DisplayName("Test greeting with empty string")
    public void testGetGreetingWithEmptyString() {
        String result = app.getGreeting("");
        assertEquals("Hello, World!", result);
    }
    
    @Test
    @DisplayName("Test addition of positive numbers")
    public void testAddPositiveNumbers() {
        int result = app.add(5, 10);
        assertEquals(15, result);
    }
    
    @Test
    @DisplayName("Test addition of negative numbers")
    public void testAddNegativeNumbers() {
        int result = app.add(-5, -10);
        assertEquals(-15, result);
    }
    
    @Test
    @DisplayName("Test addition with zero")
    public void testAddWithZero() {
        int result = app.add(5, 0);
        assertEquals(5, result);
    }
    
    @Test
    @DisplayName("Test even number check - true")
    public void testIsEvenTrue() {
        assertTrue(app.isEven(4));
        assertTrue(app.isEven(0));
        assertTrue(app.isEven(-2));
    }
    
    @Test
    @DisplayName("Test even number check - false")
    public void testIsEvenFalse() {
        assertFalse(app.isEven(3));
        assertFalse(app.isEven(-1));
        assertFalse(app.isEven(7));
    }
}
