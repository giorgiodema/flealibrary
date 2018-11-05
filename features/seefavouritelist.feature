Feature: SeeFavouritetList
    As a Booklover
    I want to HAVE A PROFILE
    so that I CAN SEE MY FAVOURITE LIST

Scenario: See the Favourite List 
    Given I exist as "booklover"
    And I am signed in
    And I am in profile page
    When I follow Favourite list
    Then I should be in Favourites_list page