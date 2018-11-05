Feature: Admin
    As an ADMIN
    I wanto to HAVE SPECIAL PRIVILEGES
    so that I CAN SEE ALL PROFILES

Scenario: Admin successful access
    Given I exist as "booklover"
	When I sign in
    Then I should be signed in
    And I should see "Signed in successfully." message
	And I should see admin button
    
Scenario: Admin failed access
    Given I don't exist as "admin"
    And I exist as booklover
    When I sign in
    Then I should be signed in
    And I should see "Signed in successfully." message
    And I should not see admin button