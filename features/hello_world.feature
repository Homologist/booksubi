Feature: Hello Books
    As a designer
    I want to the home page to be the login page
    So the product is simple (less pages)

    Scenario: The see the login page
        Given an non connected user
        When I go the home page
        Then I should see the login page
