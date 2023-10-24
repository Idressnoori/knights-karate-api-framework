@Regression
Feature: End to end account creation

  Scenario: Create Account end to end.
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
    * def token = "Bearer " + tokenResult.response.token
    Given path "/api/accounts/add-primary-account"
    * def data = Java.type('data.DataGenerator')
    * def emailData = data.getEmail()
    Given request
    """
        {
      "id": 584,
      "email": "#(emailData)",
      "title": "Mr.",
      "firstName": "Idress",
      "lastName": "Noori",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": 1697587200000
      }
    """
    And header Authorization = token
    When method post
    Then status 201
    And assert response.email == emailData
    * def createdAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And request
    """
    {
      "addressType": "365 hollywood road",
      "addressLine1": "",
      "city": "Stafford",
      "state": "Virginia",
      "postalCode": "22554",
      "countryCode": "",
      "current": true
    }
    """
    When method post
    Then status 201
    And assert response.postalCode == "22554"
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And request
    """
    {
      "make": "Acura",
      "model": "MDX",
      "year": "2020",
      "licensePlate": "ABC-1234"
    }
    """
    When method post
    Then status 201
    And assert response.make == "Acura"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    And request
    """
    {
      "phoneNumber": "1573248564",
      "phoneExtension": "",
      "phoneTime": "Morning",
      "phoneType": "Mobile"
    }
    """
    When method post
    Then status 201
    And assert response.phoneNumber == "1573248564"
    And print createdAccountId
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = token
    When method delete
    Then status 200
    And match response == {"status": true,"httpStatus": "OK","message": "Account Successfully deleted"}
