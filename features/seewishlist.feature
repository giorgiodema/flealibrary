Feature: SeeWishList
    As a Booklover
    I want to HAVE A PROFILE
    so that I CAN SEE MY WISH LIST

Scenario: See the Wish List 
    Given I exist as "booklover"
    And I am signed in
    And I am in profile page
    When I follow Wish list
    Then I should be in Wish_List page