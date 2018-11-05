Feature: AddABookToGift
    As a BOOKLOVER 
    I want to ADD A BOOK TO MY GIFT LIST 
    so that I CAN CREATE AN AD

Scenario: Add a Book to Gift
    Given I exist as "booklover"
    And I am signed in
    And I am in books_results page
    When I follow Gift
    Then it should be in the gift ad database 
