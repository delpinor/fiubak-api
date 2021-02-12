Feature: Tasks CRUD

  Background:
    Given User "John" is already registered

  Scenario: t1 - Assign task to user
    When I assign a task with title "Clean floor" to the last user created
    And I get the last task created
    Then I should get task "Clean floor"

  Scenario: t2 - Assign new tag to task
    Given a task with title "Clean floor" is already assigned to the last user created
    When I assign a tag with name "Weekly" to the last task created
    And I get the last task created
    Then I should get task "Clean floor"
    And the task should have a tag assigned "Weekly"

  Scenario: t3 - Assign existing tag to task
    Given a task with title "Clean floor" is already assigned to the last user created
    And a tag already exists with name "Monthly"
    When I assign a tag with name "Monthly" to the last task created
    And I get the last task created
    Then I should get task "Clean floor"
    And the task should have a tag assigned "Monthly"

  Scenario: t4 - Assign two tags to task
    Given a task with title "Clean floor" is already assigned to the last user created
    When I assign a tag with name "Important" to the last task created
    And I assign a tag with name "Weekly" to the last task created
    And I get the last task created
    Then I should get task "Clean floor"
    And the task should have a tag assigned "Important"
    And the task should have a tag assigned "Monthly"
