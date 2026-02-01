package com.jenkins.test;

/**
 * Simple application for testing Jenkins CI pipeline
 */
public class App {
    
    public static void main(String[] args) {
        System.out.println("Jenkins CI Demo Application");
        System.out.println("============================");
        
        App app = new App();
        String greeting = app.getGreeting("Jenkins");
        System.out.println(greeting);
        
        int sum = app.add(5, 10);
        System.out.println("5 + 10 = " + sum);
        
        System.out.println("\nApplication executed successfully!");
    }
    
    /**
     * Returns a greeting message
     * @param name The name to greet
     * @return A greeting message
     */
    public String getGreeting(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "Hello, World!";
        }
        return "Hello, " + name + "!";
    }
    
    /**
     * Adds two numbers
     * @param a First number
     * @param b Second number
     * @return Sum of a and b
     */
    public int add(int a, int b) {
        return a + b;
    }
    
    /**
     * Checks if a number is even
     * @param number The number to check
     * @return true if even, false otherwise
     */
    public boolean isEven(int number) {
        return number % 2 == 0;
    }
}
