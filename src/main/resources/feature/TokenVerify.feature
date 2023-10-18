Feature: Security token verify API calls

  Scenario: Send valid request to /api/token/verify
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request {"username":"supervisor","password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response.message == "Token is valid"

    Scenario: Send valid username invalid token to /api/token/verify
      Given url "https://qa.insurance-api.tekschool-students.com"
      And request {"username":"supervisor","password":"Wrong password"}
      And path "/api/token/verify"
      And param username = "supervisor"
      And param token = "Wrong Token"
      When method get
      And print response
      Then status 400
      And assert response.errorMessage == "Token Expired or Invalid Token"

    Scenario: Send Invalid username valid token to /api/token/verify
      And path "/api/token"
      Given url "https://qa.insurance-api.tekschool-students.com"
      And request {"username":"Supervisor","password":"tek_supervisor"}
      When method post
      Then status 200
      And print response
      And path "/api/token/verify"
      And param username = "Wrong Username"
      And param token = response.token
      When method get
      And print response
      Then status 400
      And assert response.errorMessage == "Wrong Username send along with Token"


