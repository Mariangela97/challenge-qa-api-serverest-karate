@ignore
Feature: Reusable User Creation Helper

  Scenario: Create a valid user and return its ID
    # 1. Generate a random user payload using the helper function
    * def gen = read('classpath:users/helpers/data-generator.js')
    * def payload = gen()
    
    # 2. Make the POST request for user creation
    Given url baseUrl
    And path 'usuarios'
    And request 
    """
    {
      "nome": "#(payload.name)",
      "email": "#(payload.email)",
      "password": "testpassword123",
      "administrador": "true"
    }
    """
    When method post
    Then status 201
    
    # 3. Extract the created user's ID and email for use in other tests
    * def createdId = response._id
    * def createdEmail = payload.email