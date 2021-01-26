Feature: Users CRUD

  Scenario: Create one user
    When I create the user with name "John"
    And I get the last user created
    Then I should get user "John"

  Scenario: Create invalid user
    When I create the user without a name
    Then I get should get an error message
    And I get all the users
    Then I should not get any user

  Scenario: Find one user
    Given User "John" is already registered
    When I get the last user created
    Then I should get user "John"

  Scenario: Update one user
    Given User "John" is already registered
    When I change the user name to "Paul"
    And I get the last user updated
    Then I should get user "Paul"

  Scenario: Update invalid user
    Given User "John" is already registered
    When I remove the user name
    Then I get should get an error message
    And I get the last user updated
    Then I should get user "John"

  Scenario: Update non-existing user
    Given User "John" is already registered
    When I change an invalid user name to "Paul"
    And I get the last user updated
    Then I should get user "John"

  Scenario: Find all users
    Given User "John" is already registered
    And User "Paul" is already registered
    When I get all the users
    Then I should get user "John" and "Paul"

  Scenario: Delete one user
    Given User "John" is already registered
    When I delete the user
    Then I should not get user "John"
