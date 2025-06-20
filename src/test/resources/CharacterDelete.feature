@HU-002 @CrearPersonaje
Feature: Crear personajes

  Background:
    * url baseUrl
    * def characterPayload =
    """
    {
      "name": "Iron Man",
      "alterego": "Tony Stark",
      "description": "Genius billionaire",
      "powers": ["Armor", "Flight"]
    }
    """

  @id:1 @eliminarPersonajeExitosamente
  Scenario: Eliminar personaje exitosamente
    # Primero creamos un personaje
    Given path basePath
    And request characterPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def characterId = response.id

    # Luego eliminamos el personaje
    Given path basePath + '/' + characterId
    When method DELETE
    Then status 204

  @id:2 @eliminarPersonajeInexistente
  Scenario: Eliminar personaje inexistente
    Given path basePath + '/999'
    When method DELETE
    Then status 404
    And match response.error == 'Character not found'