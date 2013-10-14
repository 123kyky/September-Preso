Feature: Interacting with the Dead Drop Map
  As Dead Drop Spy
  I want to be able to interact with the map
  So that I can find where to pickup my secret packages

Scenario Outline: Going back and forth between the Dead Drop List and Dead Drop Map
  Given I can see the Dead Drop List Screen
  When I touch "<Dead Drop Location>"
  Then I touch the "OpenMap" button
  Then I should see the Dead Drop Map
  Then I tap the Back button
  Then I should see the Dead Drop List Screen

  Examples:
  | Dead Drop Location |
  | Arch               |
  | Busch Stadium      |
  | Cathedral Basilica |
  | CocoaHeads         |
  | Illinois           |
  | Lambert            |

Scenario Outline: Tapping on a pin shows the name of the Dead Drop
  Given I can see the Dead Drop List Screen
  When I touch "<Dead Drop Location>"
  Then I touch the "OpenMap" button
  Then I touch the map pin
  Then I should see the "<Dead Drop Location>" map pin label

  Examples:
  | Dead Drop Location |
  | Arch               |
  | Busch Stadium      |
  | Cathedral Basilica |
  | CocoaHeads         |
  | Illinois           |
  | Lambert            |

Scenario: Zooming in and out on the map
  Given I can see the Dead Drop Map Screen
  Then I pinch to zoom in
  Then I pinch to zoom out