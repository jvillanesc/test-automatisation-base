@HU-001 @ConsultaPersonajes
Feature: Obtener personajes

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


  @id:1
  Scenario: Obtener todos los personajes
    # Primero creamos 2 personajes para obtenerlos
    Given path basePath
    And request characterPayload
    And def randomNum = Math.floor(Math.random() * 1000)
    And set characterPayload.name = characterPayload.name + randomNum
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    And print response

    Given path basePath
    And request characterPayload
    And def randomNum = Math.floor(Math.random() * 1000)
    And set characterPayload.name = characterPayload.name + randomNum
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    And print response


    # Obtenemos todos los personajes creados
    Given path basePath
    When method get
    Then status 200
    And print response
    And def schemaValidate = read('classpath:../data/DataSchemaCharacter.json')
    And match each response[*] contains schemaValidate
    And assert response.length == 2
    And def characters = $

    # Luego eliminamos el personaje
    Given path basePath + '/' + characters[0].id
    When method DELETE
    Then status 204
    Given path basePath + '/' + characters[1].id
    When method DELETE
    Then status 204

  @id:2
  Scenario: Obtener personaje por ID (exitoso)
    # Primero creamos un personaje para obtenerlo
    Given path basePath
    And request characterPayload
    And header Content-Type = 'application/json'
    When method POST
    Then status 201
    * def characterId = response.id

    # Luego obtenemos el personaje creado
    Given path basePath + '/' + characterId
    When method GET
    Then status 200
    And match response.name == 'Iron Man'
    And match response.alterego == 'Tony Stark'

    # Luego eliminamos el personaje
    Given path basePath + '/' + characterId
    When method DELETE
    Then status 204

  @id:3
  Scenario: Obtener personaje por ID inexistente
    Given path basePath + '/999'
    When method GET
    Then status 404
    And match response.error == 'Character not found'