Feature: Login
	As a BOOKLOVER 
	I want to LOG-IN WITH E-MAIL 
	so that I CAN ACCESS TO MY PROFILE

Scenario: Successfull login
	Given I am a booklover
  And I am on the home page
  When I login
  Then I should be on the profile page
	And I should be authenticate