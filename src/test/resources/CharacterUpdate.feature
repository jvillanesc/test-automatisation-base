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
    * def updatedPayload =
    """
    {
      "name": "Iron Man",
      "alterego": "Tony Stark",
      "description": "Updated description",
      "powers": ["Armor", "Flight"]
    }
    """

  @id:1
  Scenario: Actualizar personaje exitosamente
    # Primero creamos un personaje
    Given path basePath
    And request characterPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def characterId = response.id

    # Luego actualizamos el personaje
    Given path basePath + '/' + characterId
    And request updatedPayload
    And header Content-Type = 'application/json'
    When method PUT
    Then status 200
    And match response.description == 'Updated description'

    # Luego eliminamos el personaje
    Given path basePath + '/' + characterId
    When method DELETE
    Then status 204

  @id:2
  Scenario: Actualizar personaje inexistente
    Given path basePath + '/999'
    And request updatedPayload
    And header Content-Type = 'application/json'
    When method PUT
    Then status 404
    And match response.error == 'Character not found'