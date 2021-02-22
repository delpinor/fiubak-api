Feature: Users CRUD

  Scenario: u1 - Create one user sucessfully
    When I create the user with name "John"
    And I get the last user created
    Then I should get user "John"

  Scenario: u2 - Create invalid user without name
    When I create the user without a name
    Then I get should get an error message
    And I get all the users
    Then I should not get any user

  Scenario: u3 - Find one user
    Given User "John" is already registered
    When I get the last user created
    Then I should get user "John"

  Scenario: u4 - Update one user
    Given User "John" is already registered
    When I change the user name to "Paul"
    And I get the last user updated
    Then I should get user "Paul"

  @local
  Scenario: u5 - Update invalid user
    Given User "John" is already registered
    When I remove the user name
    Then I get should get an error message
    And I get the last user updated
    Then I should get user "John"

  Scenario: u6 - Update non-existing user
    Given User "John" is already registered
    When I change an invalid user name to "Paul"
    And I get the last user updated
    Then I should get user "John"

  Scenario: u7 - Find all users
    Given User "John" is already registered
    And User "Paul" is already registered
    When I get all the users
    Then I should get user "John" and "Paul"

  Scenario: u8 - Delete one user
    Given User "John" is already registered
    When I delete the user
    Then I should not get user "John"
