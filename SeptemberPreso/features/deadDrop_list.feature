Feature: Interacting with the Dead Drop List
  As Dead Drop Spy
  I want to be able to peruse the list of Dead Drop Locations
  So that I can find where to pickup my secret packages

Scenario Outline: Opening the Dead Drop Map
  Given I can see the Dead Drop List Screen
  When I touch "<Dead Drop Location>"
  Then I touch the "OpenMap" button
  Then I should see the Dead Drop Map Screen
  And I should see "<Dead Drop Location>" as the Screen Title

  Examples:
  | Dead Drop Location |
  | Arch               |
  | Busch Stadium      |
  | Cathedral Basilica |
  | CocoaHeads         |
  | Illinois           |
  | Lambert            |
