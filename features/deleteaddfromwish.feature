Feature: DeleteAddFromWish
    As a BOOKLOVER
    I want to DELETE A BOOK FROM MY WISH LIST
    so that I CAN MODIFY MY WISH LIST

Scenario: Delete a Book from Wish
    Given I exist as "booklover"
    And I am logged in
    And exist an ad
    And I am in profile page
    When I follow Wish list
    Then I should be in Wish_List page
    When I follow Delete
    Then it shouldn't be in the wish ad database
    