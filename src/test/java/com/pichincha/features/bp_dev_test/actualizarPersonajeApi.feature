@HU-002 @ActualizacionPersonaje
Feature: Actualizacion de personaje

  Background:
    * url port_bp_dev_test
    * def characterPayload = read('classpath:../data/bp_dev_test/request_creation_character.json')
    * def updatedPayload = read('classpath:../data/bp_dev_test/request_update_character.json')

  @id:1 @actualizarPersonajeExitosamente
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

  @id:2  @actualizarPersonajeInexistente
  Scenario: Actualizar personaje inexistente
    Given path basePath + '/999'
    And request updatedPayload
    And header Content-Type = 'application/json'
    When method PUT
    Then status 404
    And match response.error == 'Character not found'