Feature: Signup
    As an UNREGISTERED USER 
    I want to SIGN-UP WITH E-MAIL 
    so that I CAN BECOME A BOOKLOVER

Scenario: Successful signup
    Given I don't exist as "booklover"
    When I register as email@test.it, password
    Then I should be in profile page
    And I should see "Welcome! You have signed up successfully." message

Scenario: Failed signup
    Given I don't exist as "booklover"
    When I register as email, minimo
    Then I should see "errors" message