Feature: Get Account feature



  Scenario: Validate /api/accounts/get-account
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
#  //this should be the same as the created class
#  and the rest pasted in GenerateToken.feature classScenario: Generate valid Token
#  Given url "https://qa.insurance-api.tekschool-students.com"
#  Given path "/api/token"
#  Given request {"username":"supervisor","password":"tek_supervisor"}
#  When method post
#  Then status 200
    And print tokenResult
    Given path "/api/accounts/get-account"
    * def expectedId = 200
    Given param primaryPersonId = expectedId
    * def validToken = "Bearer " + tokenResult.response.token
    Given header Authorization = validToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == expectedId

  Scenario: Testing endpoint /api/accounts/get-account with primaryPersonId not exist
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
    And print tokenResult
    Given path "/api/accounts/get-account"
    * def expectedId = 99999999
    Given param primaryPersonId = expectedId
    * def validToken = "Bearer " + tokenResult.response.token
    Given header Authorization = validToken
    When method get
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id " + expectedId + " not found"



