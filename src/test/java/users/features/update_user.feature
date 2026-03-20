Feature: User Update API (PUT)

  Background:
    * url baseUrl
    # We use the create-user-helper to generate a user and get its ID and email for the update test
    * def newUser = call read('../helpers/create-user-helper.feature')
    * def userId = newUser.createdId
    * def userEmail = newUser.createdEmail

  Scenario: Update an existing user successfully
    Given path 'usuarios', userId
    And request 
    """
    {
      "nome": "Updated Name QA",
      "email": "#(userEmail)",
      "password": "newpassword123",
      "administrador": "false"
    }
    """
    When method put
    Then status 200
    And match response.message == "Registro alterado com sucesso"

  Scenario: Attempt to update a non-existent user (creates a new one)
    * def dataGenerator = read('classpath:users/helpers/data-generator.js')
    * def ghostUser = dataGenerator()
    # Here we try to update a user with an ID that doesn't exist. The API currently creates a new user instead of returning an error, which is not ideal but is the current behavior.
    Given path 'usuarios', 'non_existent_id_999'
    And request 
    """
    {
      "nome": "#(ghostUser.name)",
      "email": "#(ghostUser.email)",
      "password": "123",
      "administrador": "true"
    }
    """
    When method put
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"