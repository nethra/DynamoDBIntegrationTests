Feature: Integration Tests

Feature: Customer Initiates Cancellation of an GHS Order

  Background:
    Given a user has a valid user id
    And a valid password
    And user authenticated in system and has a valid access token

  Scenario: Customer cancels Full GHS Order
    Given a registered/anonymous customer has access token
    And provided tracing identifier '40485b12-287a-4425-8cf8-72c7d78b0d97'
    And customer wants to shop with
      | locationId                           | currency | orderReference |
      | cd39ab0b-f441-47c8-9206-938453ddc766 | GBP      | 196612277      |
    And the requester tries to place an order
    Then an order is created
    And customer adds product to this the order
      | gtin          | productId | sellerId | numberOfUnits | unitSize | unitOfMeasure |
      | 5052109948795 |           | Tesco    | 1             |          | EA            |
    Then the requester commits the order
    And requester pay for the order
    Then the requester cancel the order
    Then cancel order should be successful

  Scenario: Customer cancels an invalid order
    Given a registered/anonymous customer has access token
    And provided tracing identifier '40485b12-287a-4425-8cf8-72c7d78b0d97'
    And customer wants to shop with
      | locationId                           | currency | orderReference |
      | cd39ab0b-f441-47c8-9206-938453ddc766 | GBP      | 196612277      |
    And the requester tries to place an order
    Then an order is created
    And customer adds product to this the order
      | gtin          | productId | sellerId | numberOfUnits | unitSize | unitOfMeasure |
      | 5052109948795 |           | Tesco    | 1             |          | EA            |
    Then the requester commits the order
    And requester pay for the order
    Then the requester cancel an invalid order id
    Then an exception is returned to the requester with appropriate 400 HTTP status code with a message as 'Order identifier is empty or invalid'

  Scenario: Requester authentication check fails
    Given a registered/anonymous customer has access token
    And provided tracing identifier '40485b12-287a-4425-8cf8-72c7d78b0d97'
    And customer wants to shop with
      | locationId                           | currency | orderReference |
      | cd39ab0b-f441-47c8-9206-938453ddc766 | GBP      | 196612277      |
    And the requester tries to place an order
    Then an order is created
    And customer adds product to this the order
      | gtin          | productId | sellerId | numberOfUnits | unitSize | unitOfMeasure |
      | 5052109948795 |           | Tesco    | 1             |          | EA            |
    Then the requester commits the order
    And requester pay for the order
    And the requester cancel the order with invalid token
    And an exception is returned to the requester with appropriate 401 HTTP status code with a message as 'Authentication failed'


  Scenario: Requester authorisation check fails
    Given a registered/anonymous customer has access token
    And provided tracing identifier '40485b12-287a-4425-8cf8-72c7d78b0d97'
    And customer wants to shop with
      | locationId                           | currency | orderReference |
      | cd39ab0b-f441-47c8-9206-938453ddc766 | GBP      | 196612277      |
    And the requester tries to place an order
    Then an order is created
    And customer adds product to this the order
      | gtin          | productId | sellerId | numberOfUnits | unitSize | unitOfMeasure |
      | 5052109948795 |           | Tesco    | 1             |          | EA            |
    Then the requester commits the order
    And requester pay for the order
    And the requester cancel the order by an unauthorised client
    Then an exception is returned to the requester with appropriate 403 HTTP status code with a message as 'Permission denied for the requested resource'

  Scenario: Customer cancels GHS Order, and dependent service (GAPI) not available
    Given a registered/anonymous customer has access token
    And provided tracing identifier '40485b12-287a-4425-8cf8-72c7d78b0d97'
    And customer wants to shop with
      | locationId                           | currency | orderReference |
      | cd39ab0b-f441-47c8-9206-938453ddc766 | GBP      | 196612278      |
    And the requester tries to place an order
    Then an order is created
    And customer adds product to this the order
      | gtin          | productId | sellerId | numberOfUnits | unitSize | unitOfMeasure |
      | 5052109948795 |           | Tesco    | 1             |          | EA            |
    Then the requester commits the order
    Then the requester cancel the order
    And an exception is returned to the requester with appropriate 5XX HTTP status code with a message as 'Dependent Service Not Available'