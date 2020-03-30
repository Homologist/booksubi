
Feature: Upload
    As a user
    I want to be able to upload a file
    As a dev
    I want the uuid of a file to be created
    I want the csv to be sent to aws
    I want to see the result of the upload

    Scenario: I upload a csv
        Given a valid user
        When I go the home page
        When I log in
        Then I should see the upload page
        When I upload a valid csv
        Then I have a valid csv in my account
        Then I have a csv sent to S3
        Then I have a the url of the file sent to the bonnus destination
        Then I view all my csv
        Then I see the uuid for the file created

    Scenario: I upload a csv but there is a book with the same uuid
        Given a valid user
        Given a csv already uploaded
        When I go the home page
        When I log in
        Then I should see the upload page
        When I upload a valid csv
        When I visit the index
        Then I have no new valid csv in my account

    Scenario: I upload a csv but there is a csv with the same uuid
        Given a valid user
        Given a csv already uploaded with the fix uuid "testfixuuid"
        When I go the home page
        When I log in
        Then I should see the upload page
        When I upload a valid csv
        When I visit the index
        Then I have no new valid csv in my account
