Feature: User Deletion API (DELETE)

  Background:
    * url baseUrl
    * def newUser = call read('../helpers/create-user-helper.feature')
    * def userId = newUser.createdId

  Scenario: Delete an existing user successfully
    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == "Registro excluído com sucesso"

  Scenario: Delete a user that does not exist
    Given path 'usuarios', 'invalid_id_000'
    When method delete
    Then status 200
    And match response.message == "Nenhum registro excluído"