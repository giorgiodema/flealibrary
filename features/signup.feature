Feature: Signup
    As an UNREGISTERED USER 
    I want to SIGN-UP WITH E-MAIL 
    so that I CAN BECOME A BOOKLOVER

Scenario: Successful signup
    Given I don't exist as a user
    When I register as email@test.it, minimo
    Then I should be in profile page
    And I should see "Welcome! You have signed up successfully."

Scenario: Failed signup
    Given I don't exist as a user
    When I register as email, minimo
    Then I should be in signup page
    And I should see "errors"