Feature: Hello Books
    As a designer
    I want to the home page to be the login page
    So the product is simple (less pages)

    Scenario: I visit the home page
        Given a valid user
        When I go the home page
        Then I should see the login page

    Scenario: I m logged and I visit the login page
        Given a valid user
        When I go the home page
        When I log in
        Then I should see the upload page
