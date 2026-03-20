@ReadOnly
Feature: User Detail API (GET by ID)

  Background:
    * url baseUrl
    * def schemas = read('classpath:users/helpers/user-schema.json')
    # Create a new user using the helper to ensure we have a valid ID and email for testing
    * def newUser = call read('classpath:users/helpers/create-user-helper.feature')
    * def targetId = newUser.createdId
    * def targetEmail = newUser.createdEmail

  Scenario: Get user details successfully by valid ID
    Given path 'usuarios', targetId
    When method get
    Then status 200
    # Validate that the response matches the expected user schema and contains the correct data
    And match response == schemas.userResponse
    # Check that the returned user has the expected ID and email
    And match response._id == targetId
    And match response.email == targetEmail

Scenario: Return 400 when user ID has an invalid format (length)
    # Check the API's validation for ID length. The API should return a 400 error if the ID is not exactly 16 characters long.
    Given path 'usuarios', 'short_id'
    When method get
    Then status 400
    And match response.id == "id deve ter exatamente 16 caracteres alfanuméricos"

Scenario: Return 400 when user ID has valid format but does not exist
    # Using a 16-character alphanumeric string that is not associated with any user to test the API's response for non-existent IDs. 
    #The expected behavior is to return a 400 error indicating the user was not found.
    Given path 'usuarios', '1234567890abcdef'
    When method get
    Then status 400
    And match response.message == "Usuário não encontrado"