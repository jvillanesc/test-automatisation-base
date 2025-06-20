@HU-002 @CrearPersonaje
Feature: Crear personajes

  Background:
    * url baseUrl
    * def characterPayload = read('classpath:../data/bp_dev_test/request_creation_character.json')
    * def invalidPayload = read('classpath:../data/bp_dev_test/request_invalid_creation_character.json')

  @id:1 @crearUnPersonajeExitosamente
  Scenario: Crear un personaje exitosamente
    # Primero creamos un personaje para obtenerlo
  Scenario: Crear un personaje exitosamente
    Given path basePath
    And request characterPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    And match response.name == 'Iron Man'
    And match response.id == '#notnull'
    * def characterId = response.id
    * def characterId = response.id

    # Luego eliminamos el personaje
    Given path basePath + '/' + characterId
    When method DELETE
    Then status 204

  @id:2 @crearPersonajeConNombreDuplicado
  Scenario: Crear personaje con nombre duplicado
    # Primero creamos un personaje
    Given path basePath
    And request characterPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    And def characterId = response.id

    # Intentamos crear un personaje con el mismo nombre
    Given path basePath
    And request characterPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 400
    And match response.error == 'Character name already exists'

    # Luego eliminamos el personaje
    Given path basePath + '/' + characterId
    When method DELETE
    Then status 204

  @id:3 @crearPersonajeConCamposRequeridosFaltantes
  Scenario: Crear personaje con campos requeridos faltantes
    Given path basePath
    And request invalidPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
    And match response.description == 'Description is required'
    And match response.powers == 'Powers are required'