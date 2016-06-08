fs = require 'fs'
jsdiffConsole = require 'jsdiff-console'
ObservableProcess = require 'observable-process'
path = require 'path'
tmp = require 'tmp'


module.exports = ->

  @Given /^a Cucumber spec with missing step implementation for$/, (step) ->
    @tmpDir = tmp.dirSync()
    fs.mkdirSync path.join @tmpDir.name, 'features'
    fs.writeFileSync path.join(@tmpDir.name, 'features', 'test.feature'),
                       """
                       Feature: test app

                         Scenario: missing step
                           #{step}
                       """


  @When /^running Cucucumber\-JS with this package enabled$/, (done) ->
    command = "#{path.join process.cwd(), 'node_modules', '.bin', 'cucumber-js'} --snippet-syntax #{path.join process.cwd(), 'index'} --no-colors"
    @observer = new ObservableProcess command, cwd: @tmpDir.name
    @observer.wait '1 scenario', done


  @Then /^Cucumber provides the step implementation template:$/, (template, done) ->
    output = @observer.fullOutput().replace /\n/g, '\\n'
    result = /Implement with the following snippet:\\n\\n(.*)\\n\\n/i.exec output
    snippet = result[1].replace(/\\n/g, '\n').replace(/       /g, '')
    jsdiffConsole snippet.trim(), template.trim(), done
