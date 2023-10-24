Feature: Create Account with Random Email using java

  Scenario: Create valid account /api/accounts/add-primary-account
    Given url "https://qa.insurance-api.tekschool-students.com"
    Given path "/api/accounts/add-primary-account"
    * def dataGenerator = Java.type('data.DataGenerator')
    *  def autoEmail = dataGenerator.getEmail();
    * def autoFirstName = dataGenerator.getFirstName();
    And request
    """
  {
  "id": 0,
  "email": "#(autoEmail)",
  "firstName": "Idress",
  "lastName": "Noori",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Student",
  "dateOfBirth": "2023-10-18",
  "new": true
  }
    """
    When method post
    Then print response
    Then status 201
    Then assert response.email == autoEmail
