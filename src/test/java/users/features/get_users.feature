@ReadOnly
Feature: User Search API

  Background:
    * url baseUrl
    * def schemas = read('../helpers/user-schema.json')

  Scenario: Retrieve all registered users and validate contract
    Given path 'usuarios'
    When method get
    Then status 200
    # Validate that the response contains an array of users and matches the expected schema
    And match response.usuarios == '#[]'
   And match each response.usuarios == schemas.userResponse
    * print 'Total users found: ', response.quantidade