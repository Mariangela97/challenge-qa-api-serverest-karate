Feature: Gestión de Usuarios - Listar

  Background:
    * url baseUrl

  Scenario: Obtener lista de usuarios registrados
    Given path 'usuarios'
    When method get
    Then status 200
    And match response.usuarios == '#[]'
    * print 'Total de usuarios encontrados: ', response.quantidade