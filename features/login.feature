Feature: Login
	As a BOOKLOVER 
	I want to LOG-IN WITH E-MAIL 
	so that I CAN ACCESS TO MY PROFILE

Scenario: Successfull login
	Given I exist as a user
	When I login with valid credentials
	Then I see a successful sign in message
	And I should be in profile
	And I should be signed in