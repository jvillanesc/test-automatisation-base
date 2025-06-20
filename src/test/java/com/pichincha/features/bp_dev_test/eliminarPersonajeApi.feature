@HU-002 @EliminarPersonajes
Feature: Eleminar personajes

  Background:
    * url baseUrl
    * def characterPayload = read('classpath:../data/bp_dev_test/request_creation_character.json')

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