Feature: Dokk1
  Scenario: Frontpage
    Given I am on "/"
    When I follow "Det sker på Dokk1" in the "header" element
    # When I follow the 2nd "Det sker på Dokk1" link
    Then I should be on "/det-sker/arrangementer"
    And I should see "Det sker på Dokk1"

  Scenario: Events
    Given I am on "/det-sker/arrangementer"
    Then I should see "Det sker på Dokk1"

    When I fill in "Søg efter arrangement..." with "sprogcafe"
    And I press "Søg"
    Then I should be on "/det-sker/arrangementer?search=sprogcafe"
    And I should see "Mandag, 30/4-2018"
    # And I save a screenshot in "search.jpg"

  Scenario: Opening hours
    Given I am on "/"
    And I wait 20 seconds until I see "Åbningstider" in the "main" element
    And I follow "Åbningstider" in the "main" element
