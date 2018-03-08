Feature: Handle user registration via the RESTful API

  In order to allow a user to sign up
  As a client software developer
  I need to be able to handle registration

  Background:
    Given there are Users with the following details:
      | id | username | email          | password |
      | 1  | peter    | peter@test.com | testpass |
    And I set header "Content-Type" with value "application/json"
@this4
  Scenario: Can register with valid data
    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/register" with body:
      """
      {
        "email": "chris@codereviewvideos.com",
        "username": "chris",
        "plainPassword": {
          "first": "abc123",
          "second": "abc123"
        }
      }
      """
    Then the response code should be 201
    And the response should contain "registration.flash.user_created"
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA1MDI1MTYsInVzZXJuYW1lIjoiY2hyaXMiLCJpYXQiOiIxNTIwNDE2MTE2In0.MowaPXFxMyStFli-V2zSfSUGhrz_zN091sQGEyVrx4byC1i3GDjcZXJAEO8X3tQs4n-yF5s_etG7eTcUH7IWFm1jvRw1TXGR8IiaX4E0LHJOAKloKgDpS3j9cekjar19PaYsZ50q6zUzH3Ntuvi44WA06AT0fDzK_qIE1Pu0vdrq3H8GhEM2Oiyc6cnlLZd1f11IP-JJI7k86TWx2uxNbqlMq4CpFI_YMpfJgKQSXLn3JYN3MQiCSipIMefomyZr7WxU17ccneRbkLRjDhy7p_KHCRArRUExRgTCPe-zFljTTGJ3A9l5Gck2FH7zEs2QZw7SbdtQ4E0Tj7HkVkgbeDIdzU7YXKtTgP8x7g_HsgzxGtYAPkFfSLURcL0i9JGhOWYVT7NE06Qg7P7amZAuSdDozwNQdvgOwTCD2LPsdDAaavM6LFj5xGH_-BGjuOMqaRcbzlMvLQS0xWXxp3kfr8oeUDFvp-RHRdw51bUkKXFZEcvksbMNbr_GtHwAFz-B0eGQwx7Zo_8YQs-OMmfNNuDjqx9HRrY1o1KfM7QkQAQ-WVP4isysgFfAu37q6bWEKzNafMwd_EvAUxDx41x_xJC5Kzc8OXvJNJp5hNM0lZwL82kqdovV_fFc7NeH5dGVugxn_9rEy83QifmPMwq2KOvkb-aYeWyWhQT4PhTK1dY"
#    And I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/2"
    And I follow the link in the Location response header
    And the response should contain json:
      """
      {
        "id": "2",
        "username": "chris",
        "email": "chris@codereviewvideos.com"
      }
      """
      @this4
  Scenario: Cannot register with existing user name
    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/register" with body:
      """
      {
        "email": "peter@some-different-domain.com",
        "username": "peter",
        "plainPassword": {
          "first": "abc123",
          "second": "abc123"
        }
      }
      """
    Then the response code should be 400
    And the response should contain "fos_user.username.already_used"
  @this4
  Scenario: Cannot register with an existing email address
    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/register" with body:
      """
      {
        "email": "peter@test.com",
        "username": "different_peter",
        "plainPassword": {
          "first": "abc123",
          "second": "abc123"
        }
      }
      """
    Then the response code should be 400
    And the response should contain "fos_user.email.already_used"
  @this4
  Scenario: Cannot register with an mismatched password
    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/register" with body:
      """
      {
        "email": "gary@test.co.uk",
        "username": "garold",
        "plainPassword": {
          "first": "gaz123",
          "second": "gaz456"
        }
      }
      """
    Then the response code should be 400
    And the response should contain "fos_user.password.mismatch"