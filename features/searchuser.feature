Feature: SearchUser
	As a BOOKLOVER 
	I want to SEARCH ANOTHER USER
	so that I CAN SEE HIS PROFILE

Scenario: Successful SearchUser
    Given I am logged in as other user
	And I am in home page
	When I search "name_test" user
	Then I should be in users_list page
	And I should see "name_test"

Scenario: Unsuccessful SearchUser
    Given I am logged in as other user
    And I am in home page
    When I search "failed" user
    Then I should be in home page
    And I should see "No result found" message
