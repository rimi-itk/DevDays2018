Feature: Bobpol
  Scenario: Frontpage
    Given I am on "/"
    When I follow "BOB Politikken"
    # When I save a screenshot in "frontpage.jpg"
    Then I should be on "/bob-politikken"
    And I should see "BOB politikken"
    # And show last response
