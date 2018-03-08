## /src/AppBundle/Features/password_reset.feature
#
#Feature: Handle password changing via the RESTful API
#
#  In order to help users quickly regain access to their account
#  As a client software developer
#  I need to be able to let users request a password reset
#
#  Background:
#    Given there are Users with the following details:
#      | uid | username | email          | password | confirmation_token |
#      | u1  | peter    | peter@test.com | testpass |                    |
#      | u2  | john     | john@test.org  | johnpass | some-token-string  |
#    And I set header "Content-Type" with value "application/json"
#
#  ############################
#  ## Password Reset Request ##
#  ############################
#  @this11
#  Scenario: Cannot request a password reset for an invalid username
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/request" with body:
#      """
#      { "username": "davey" }
#      """
#    Then the response code should be 403
#    And the response should contain "User not recognised"
#  @this12
#  Scenario: Can request a password reset for a valid username
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/request" with body:
#      """
#      { "username": "peter" }
#      """
#    Then the response code should be 200
#    And the response should contain "resetting.check_email"
#@this13
#  Scenario: Cannot request another password reset for an account already requesting, but not yet actioning the reset request
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/request" with body:
#      """
#      { "username": "john" }
#      """
#    Then the response code should be 403
#    And the response should contain "resetting.password_already_requested"
#
#  ############################
#  ## Password Reset Confirm ##
#  ############################
#@this21
#  Scenario: Cannot confirm without a token
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/confirm" with body:
#      """
#      { "bad": "data" }
#      """
#    Then the response code should be 400
#    And the response should contain "You must submit a token."
#@this22
#  Scenario: Cannot confirm with an invalid token
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/confirm" with body:
#      """
#      { "token": "invalid token string" }
#      """
#    Then the response code should be 400
#@this23
#  Scenario: Cannot confirm without a valid new password
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/confirm" with body:
#      """
#      {
#        "token": "some-token-string",
#        "plainPassword": {
#          "second": "first-is-missing"
#        }
#      }
#      """
#    Then the response code should be 400
#    And the response should contain "fos_user.password.mismatch"
#@this24
#  Scenario: Cannot confirm with a mismatched password and confirmation
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/confirm" with body:
#      """
#      {
#        "token": "some-token-string",
#        "plainPassword": {
#          "first": "some password",
#          "second": "oops"
#        }
#      }
#      """
#    Then the response code should be 400
#    And the response should contain "fos_user.password.mismatch"
#@this25
#  Scenario: Can confirm with valid new password
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/reset/confirm" with body:
#      """
#      {
#        "token": "some-token-string",
#        "plainPassword": {
#          "first": "new password",
#          "second": "new password"
#        }
#      }
#      """
#    Then the response code should be 200
#    And the response should contain "resetting.flash.success"
#    And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/login" with body:
#      """
#      {
#        "username": "john",
#        "password": "new password"
#      }
#      """
#    Then the response code should be 200
#    And the response should contain "token"
