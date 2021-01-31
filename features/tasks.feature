Feature: Tasks CRUD

  Background:
    Given User "John" is already registered

  Scenario: Assign task to user
    When I assign a task with title "Clean floor" to the last user created
    And I get the last task created
    Then I should get task "Clean floor"
