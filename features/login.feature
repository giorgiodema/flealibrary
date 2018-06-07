Feature: Login
	As a BOOKLOVER 
	I want to LOG-IN WITH E-MAIL 
	so that I CAN ACCESS TO MY PROFILE

Scenario: Successfull login
	Given I exist as a user
	#And I am not logged in
	When I login
	Then I should see "Signed in successfully."
	And I should be in profile page
	And I should be signed in

Scenario: Failed login
	Given I don't exist as a user
	#And I am not logged in
	When I login
	Then I should see "Invalid Email or password."
	And I should be in login page