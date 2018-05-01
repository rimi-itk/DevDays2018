Feature: Eventbillet
  Scenario: Frontpage
    Given I am on "/itk-dev/behat/"
    And I fill in "item_38" with "2"
    And press "Add to cart"
    And I wait 8 seconds until I see "The products have been successfully added to your cart."

    Then I should be on "/itk-dev/behat/"
    And I should see "Your cart"

    When I follow "Proceed with checkout"
    Then I should be on "/itk-dev/behat/checkout/questions/"
    And should see "Checkout"

    When I fill in "E-mail" with "test@example.com"
    And press "Continue"
    Then I should be on "/itk-dev/behat/checkout/payment/"
    And should see "Please select how you want to pay."
    And should see "DIBS"

    When I select "dibs" from "payment"
    And press "Continue"
    Then I should be on "/itk-dev/behat/checkout/confirm/"
    And should see "Review order"

    When I press "Place binding order"
    # Wait for redirect
    And I wait 8 seconds
    Then I should be on "https://payment.architrade.com/paymentweb/start.action"
    And should see "Vælg betalingsform"

    When I press "Dankort / VISA-Dankort"
    # Then I should be on "https://payment.architrade.com/paymentweb/paytype.action"
    And should see "Udfør betaling"

    When I fill in the following:
      | cardno  | 4571100000000000 |
      | expmon  |               06 |
      | expyear |               24 |
      | cvc     |              684 |
    And press "Udfør betaling"
    Then I should be on "https://payment.architrade.com/paymentweb/auth.action"
    And should see "Betalingen er godkendt."

    When I press "Videre"
    And wait 8 seconds
    Then I should see "Your order"
    And should see "Paid"
