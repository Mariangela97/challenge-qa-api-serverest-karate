@Write
Feature: User Creation API

  Background:
    * url baseUrl
    * def dataGenerator = read('../helpers/data-generator.js')
    * def userPayload = dataGenerator()

  Scenario: Create a new user successfully
    Given path 'usuarios'
    And request 
    """
    {
      "nome": "#(userPayload.name)",
      "email": "#(userPayload.email)",
      "password": "123",
      "administrador": "true"
    }
    """
    When method post
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"

  Scenario: Fail to create a user with an existing email
    # First, we create a user to ensure the email is already in use
    * def firstUser = dataGenerator()
    Given path 'usuarios'
    And request
    """
    {
      "nome": "First",
      "email": "#(firstUser.email)",
      "password": "123",
      "administrador": "true"
    }
    """
    When method post
    Then status 201
    
    # Now we attempt to create another user with the same email, which should fail
    Given path 'usuarios'
    And request 
    """
    {
      "nome": "Second",
      "email": "#(firstUser.email)",
      "password": "123",
      "administrador": "true"
    }
    """
    When method post
    Then status 400
    And match response.message == "Este email já está sendo usado"


    Scenario: Fail to create a user when sending an empty request
    Given path 'usuarios'
    And request {}
    When method post
    Then status 400
    # The API should return a message indicating that all fields are required
    And match response == 
    """
    {
      "nome": "nome é obrigatório",
      "email": "email é obrigatório",
      "password": "password é obrigatório",
      "administrador": "administrador é obrigatório"
    }
    """

  Scenario Outline: Validate error messages for empty string fields
    Given path 'usuarios'
    And request 
    """
    {
      "nome": "<name>",
      "email": "<email>",
      "password": "<password>",
      "administrador": "<admin>"
    }
    """
    When method post
    Then status 400
    And match response.<field> == "<message>"

    Examples:
      | name | email            | password | admin | field         | message                                   |
      |      | test@test.com    | 123      | true  | nome          | nome não pode ficar em branco             |
      | QA   |                  | 123      | true  | email         | email não pode ficar em branco            |
      | QA   | test2@test.com   |          | true  | password      | password não pode ficar em branco         |
      | QA   | test3@test.com   | 123      |       | administrador | administrador deve ser 'true' ou 'false'  |