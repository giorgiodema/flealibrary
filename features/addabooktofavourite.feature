Feature: Add a 
    As a BOOKLOVER
    I want to ADD AN AD TO MY FAVORITES
    so that I CAN FIND IT SIMPLY

Scenario: Add a Book to Favourite
    Given I exist as "booklover"
    And I am logged in
    And exist another ad
    And I am in home page
    When I search for ads
    Then I should be in ads_list page
    When I follow Favourite
    Then it should be in the favourite ad database 
