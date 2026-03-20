@Management
Feature: User Management - Full CRUD Flow

  Background:
    * url baseUrl
    * def dataGenerator = read('../helpers/data-generator.js')
    * def userPayload = dataGenerator()

  Scenario: Create, read, update and delete a user successfully
    # 1. POST - Create User
    Given path 'usuarios'
    And request 
    """
    {
      "nome": "#(userPayload.name)",
      "email": "#(userPayload.email)",
      "password": "testpassword123",
      "administrador": "true"
    }
    """
    When method post
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    * def userId = response._id

    # 2. GET - Read User by ID
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response.email == userPayload.email
    And match response._id == userId
    * def schema = read('../helpers/user-schema.json')
    And match response == schema.userResponse

    # 3. PUT - Update User
    Given path 'usuarios', userId
    And request 
    """
    {
      "nome": "Updated Name QA",
      "email": "#(userPayload.email)",
      "password": "newpassword456",
      "administrador": "true"
    }
    """
    When method put
    Then status 200
    And match response.message == "Registro alterado com sucesso"

    # 4. DELETE - Remove User
    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == "Registro excluído com sucesso"

    # 5. GET - Verify Deletion (Negative Case)
    Given path 'usuarios', userId
    When method get
    Then status 400
    And match response.message == "Usuário não encontrado"