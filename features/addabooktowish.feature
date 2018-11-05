Feature: AddABookToWish
    As a BOOKLOVER
    I want to ADD A BOOK TO MY WISH LIST
    so that I CAN CREATE AN AD

Scenario: Add a Book to Wish 
    Given I exist as "booklover"
    And I am signed in
    And I am in books_results page
    When I follow Wish
    Then it should be in the wish ad database 
