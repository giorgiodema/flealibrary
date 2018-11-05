Feature: SignIn
	As a BOOKLOVER 
	I want to LOG-IN WITH E-MAIL 
	so that I CAN ACCESS TO MY PROFILE

Scenario: Successfull sign in
	Given I exist as "booklover"
	And I am not signed in
	When I sign in
	Then I should see "Signed in successfully." message
	And I should be in profile page
	And I should be signed in

Scenario: Failed sign in
	Given I don't exist as "booklover"
	And I am not signed in
	When I sign in
	Then I should see "Invalid Email or password." message
	And I should be in signin page