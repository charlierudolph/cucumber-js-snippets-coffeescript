Feature: Templates for missing Cucumber steps in CoffeeScript

  As a CoffeeScript developer writing feature specs in Cucumber
  I'd like the templates for missing step implementations be provided in CoffeeScript
  So that I can copy and paste them straight into my code.

  - templates for implementing steps are provided in CoffeeScript


  Scenario: running a scenario with a missing step implementation
    Given a Cucumber spec with missing step implementation for
      """
      Given I TDD a "demo" application using Cucumber
      """
    When running Cucucumber-JS with this package enabled
    Then Cucumber provides the step implementation template:
      """
      @Given /^I TDD a "([^"]*)" application using Cucumber$/, (arg1, callback) ->
        # Write code here that turns the phrase above into concrete actions
        callback.pending()
      """
