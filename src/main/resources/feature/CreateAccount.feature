Feature: Create Account Testing
#Activity:
#  End point: /api/accounts/add-primary-account
#  send request
#  validate response is 201
#  and response contain your request. email entity is correct
  Scenario: Create account testing /api/accounts/add-primary-account
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
    * def token = "Bearer " + tokenResult.response.token
    Given path "/api/accounts/add-primary-account"
    Given request
    """
        {
      "id": 584,
      "email": "idressnoori@yahoo.com",
      "title": "Mr.",
      "firstName": "Idress",
      "lastName": "Noori",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": 1697587200000
      }
    """
    When method post
    Then status 201
    And print response
    And assert response.email == "idressnoori@yahoo.com"
    * def createdAccountId = response.id
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    When method delete
    Then status 200
    And print response
#  the test need to be run before validate(assert) the test. and after the test run
#  i copied the message "Account seffuly deleted"from the console
    And assert response.message == "Account Successfully deleted"


