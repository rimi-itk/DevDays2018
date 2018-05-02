@user
Feature: Bobpol - User - Register
  Scenario: Register as new user
    # Given I am on "/"
    # @FIXME When I follow "/user" (no such link)
    # Then I should be on "/user/login"

    Given I am on "/user"

    When I follow "Opret konto"
    Then I should be on "/user/register"
    # @FIXME And the ".password-confirm" element should not be visible

    When I fill in the following:
      | First name          | John                |
      | Last name           | Doe                 |
      | E-mail              | johndoe@example.com |
      | Adgangskode         | pass1234            |
      | Bekræft adgangskode | pass123             |
    Then the ".password-confirm" element should be visible
    And I should see "Adgangskoder er ens: nej"

    When I press "Opret konto"
    Then I should be on "/user/register"
    And I should see "De angivne adgangskoder er forskellige."

    When I fill in the following:
      | Adgangskode         | pass1234 |
      | Bekræft adgangskode | pass1234 |
    Then the ".password-confirm" element should be visible
    And I should see "Adgangskoder er ens: ja"

    When I press "Opret konto"
    Then I should be on "/"
    And I should see "Registrering lykkedes. Du er nu logget ind."

    When I follow "Log ud"
    Then I should be on "/"
    And I should not see "Log ud"

  Scenario: Register as already existing user
    Given I am on "/user/register"

    When I fill in the following:
      | First name          | John                |
      | Last name           | Doe                 |
      | E-mail              | johndoe@example.com |
      | Adgangskode         | pass1234            |
      | Bekræft adgangskode | pass1234            |

    When I press "Opret konto"
    Then I should be on "/user/register"
    And I should see "E-mailadressen johndoe@example.com er allerede i brug."

  @email @hmm
  Scenario: Forgotten password
    Given I am on "/user/login"
    And I follow "Nulstil din adgangskode"
    Then I should be on "/user/password"

    When I fill in "E-mail" with "john@example.com"
    And press "Indsend"
    Then I should see "john@example.com findes ikke som brugernavn eller e-mail-adresse." in the ".alert-danger" element

    When I fill in "E-mail" with "johndoe@example.com"
    And press "Indsend"
    Then I should see "Yderligere instruktioner er sendt til din e-mail-adresse." in the ".alert-success" element

    When I follow the 1st link in email sent to "johndoe@example.com"
    Then the url should match "^/user/reset/[0-9]+$"

    When I press "Log ind"
    Then the url should match "^/user/[0-9]+/edit$"
    And I should see "Du har netop brugt dit engangs-login-link. Det er ikke længere nødvendigt at bruge dette link til at logge ind. Skift venligst din adgangskode."
    And show last response

    When I fill in the following:
      | Adgangskode           | new1234  |
      | Bekræft adgangskode   | new1234  |
    And I press "Gem"
    Then the url should match "^/user/[0-9]+/edit$"
    And I should see "Ændringerne er blevet gemt."

    When I follow "Log ud"
    Then I should be on "/"

    When I am on "/user/login"
    And I fill in the following:
      | E-mail              | johndoe@example.com |
      | Adgangskode         | new1234             |
    And press "Log ind"
    Then the url should match "^/bruger/[0-9]+$"
