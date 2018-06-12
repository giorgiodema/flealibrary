Feature: SeeGiftList
    As a Booklover
    I want to HAVE A PROFILE
    so that I CAN SEE MY GIFT LIST

Scenario: See the Gift List 
    Given I exist as "booklover"
    And I am logged in
    And I am in profile page
    When I follow Gift list
    Then I should be in Gift_List page