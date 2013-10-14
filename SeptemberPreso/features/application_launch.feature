Feature: Launching the application
  As Dead Drop Spy
  I want to be able to successfully launch
  and navigate into the application
  So that I can enjoy using it without any problems

Scenario: Successfully launching the application
  Given I have launched the application
  Then I should see the Home Screen
  
Scenario: Successfully navigating past the Home Screen and into the application
	Given I can see the Home Screen
	When I swipe up on "HomeScreen"
	Then I should see the Dead Drop List
	And I should see the Dead Drop Mini Map