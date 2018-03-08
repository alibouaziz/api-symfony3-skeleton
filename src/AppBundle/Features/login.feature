# /src/AppBundle/Features/login.feature

#Feature: Handle user login via the RESTful API
#
#  In order to allow secure access to the system
#  As a client software developer
#  I need to be able to let users log in and out
##-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#
#    And I set header "Content-Type" with value "application/json"
#@one
#  Scenario: Cannot GET Login
#    When I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/login"
#    Then the response code should be 405
#@two
#  Scenario: User cannot Login with bad credentials
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/login" with body:
#      """
#      {
#        "username": "jimmy",
#        "password": "badpass"
#      }
#      """
#    Then the response code should be 401
#@three
#  Scenario: User can Login with good credentials (username)
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/login" with body:
#      """
#      {
#        "username": "john",
#        "password": "johnpass"
#      }
#      """
#    Then the response code should be 200
#    And the response should contain "token"
#@for
#  Scenario: User can Login with good credentials (email)
#    When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/login" with body:
#      """
#      {
#        "username": "peter@test.com",
#        "password": "testpass"
#      }
#      """
#    Then the response code should be 200
#    And the response should contain "token"
# ----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#    #And I am successfully logged in with username: "peter", and password: "testpass"
#    And I set header "Content-Type" with value "application/json"
#
#  Scenario: Cannot view a profile with a bad JWT
#    When I set header "Authorization" with value "Bearer bad-token-string"
#    And I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1"
#    Then the response code should be 401
#    And the response should contain "Invalid JWT Token"
#
#  Scenario: Can view own profile
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1"
#    Then the response code should be 200
#    And the response should contain json:
#      """
#      {
#        "id": "1",
#        "username": "peter",
#        "email": "peter@test.com"
#      }
#      """
#
#  Scenario: Cannot view another user's profile
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/2"
#    Then the response code should be 403
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#
#    And I set header "Content-Type" with value "application/json"
#
#  # snip
#
#  Scenario: Can replace their own profile
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "PUT" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1" with body:
#      """
#      {
#        "username": "peter",
#        "email": "new_email@test.com",
#        "current_password": "testpass"
#      }
#      """
#    Then the response code should be 204
#    And I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1"
#    And the response should contain json:
#      """
#      {
#        "id": "1",
#        "username": "peter",
#        "email": "new_email@test.com"
#      }
#      """
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#
#    And I set header "Content-Type" with value "application/json"
#
#  Scenario: Must supply current password when updating profile information
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "PUT" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1" with body:
#      """
#      {
#        "email": "new_email@test.com"
#      }
#      """
#    Then the response code should be 400
#
#  Scenario: Cannot replace another user's profile
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "PUT" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/2" with body:
#      """
#      {
#        "username": "peter",
#        "email": "new_email@test.com",
#        "current_password": "testpass"
#      }
#      """
#    Then the response code should be 403
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#
#    And I set header "Content-Type" with value "application/json"
#
#  Scenario: Can update their own profile
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "PATCH" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1" with body:
#      """
#      {
#        "email": "different_email@test.com",
#        "current_password": "testpass"
#      }
#      """
#    Then the response code should be 204
#    And I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjAzNDY2ODgsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQzMDg4In0.tGmAYwzudAgh_eSLL-xvh-bJ7cmGx6vYT-b0n98k3YhX26SM_7ylkywvfNxU1IRsR44QX2bsUPotONyaaJhCON0hxk7RbUGlgbv6SUHzq2dd1bRhvJzX14Vv11iCu0aKNcioZBRFWEHeW1nxyHjpHRwU9vNgj6gJp2MTtlxE06xM3dFunfUZ6wSJgK-ZsTkyaeQqudDZWqop5JRC77lzuNeTBO8TwbifSN7AHIp4z4wRq1aZLfRITQMP1JnN_lnZG4TxCM290b30eNJblkhTcnkP4nkkE5temTFjMc41Blwwmeu9gUdPkpwxuP-rjF7K0Z1wcIqgfF6lCVklF06YBCd7C6_p2jpc7HzzPVfFPFEJ6Mu4FnLW636a5XvHbhd8oUP9XBu_W55s8neM63fITUYKafxHSyuIGNpzApQtbLNM_6kRWuTr8r4ZHA_mKqxA0pGpmNcfm_vkEMKpbgJffEcDLsBWNaAEpHch0HbgW2L9ThHscnW18ViwJuLl7GcLZmFhpw015fOilzEZmbVqhQYRirxH4y2suKvYph4xRWA-TKcSxfeIAQ91f8uZOTnbdvbg-1pG_CYnwmmOEW3hjGjfAz3Uxd_bmy7UXsT7LWBTNmwwlIiJIoYPOwIVJkzk5m1HkPuPIKkV8IX1_YQk6Cai6qCUaPLKeH679tE00xY"
#    And I send a "GET" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/1"
#    And the response should contain json:
#      """
#      {
#        "id": "1",
#        "username": "peter",
#        "email": "different_email@test.com"
#      }
#      """
#-----------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#
#    And I set header "Content-Type" with value "application/json"
#
#  Scenario: Cannot update another user's profile
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0MzQyNDYsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQ3ODQ2In0.ZWMPBoq1ClW447GccsWF1cwS_A02qaQ39U1UHt7jnOcE40hPbvptuNQGFGoS8CDc6l53lvUbdXtYNifD3U8IoXJDp2ROtvBSergNeWUhW5VQtV-Mc8B-7GfMgJRrWhSAPOlnL-FrgXA1urYz902pL7mwBKWGrgc-xxJhD7XPNnHzX2y6CMvH5qh_HQS5wFB80frqB5Hyi6MlLMCoyZDeykcsQybB2KuChtcIjZK1EeGzVtYA5IqZxLqWu4RPOqcqfo0ca_j9-2pWVnC889iWu4jxGju3neGzwz_B5RGq7Vzql81F51h07gZ9aobO6XargRIvXDe4ItbaRZtiuAvf5rwbzdW6SbHuJIDF0K465-9VI6Zt1WwyCie0qB97GTR4RiFQvqZ4CcuNTbsugDLUjwBhxBCIXbhk4gMhq7MTBR1C_DefQ3YEYKTRvgGHzzx50qhUBserJVjhqu_BQg93O7qJNPCJh8ch912CViDMiANR2vs7hUAfhvnJiMcSLtJL75KCW3-uXMBzio-0y5TXB3gHLCL6DdbJD5CQct5lNKYodQ3rZ5vdE7_YAILfEA5fCUck70HQVR9JSMIdCZPwQAY_V8sOyUMwFDAp7z4gpCiNnlsUfn6y_aQ0MknZDmksCPWsxRuBgnIjVTguHjZzpmA9Y613n1e6t4eIXnp1GYs"
#    And I send a "PATCH" request to "http://localhost/api-code-review/web/app_acceptance.php/profile/2" with body:
#      """
#      {
#        "username": "peter",
#        "email": "new_email@test.com",
#        "current_password": "testpass"
#      }
#      """
#    Then the response code should be 403
#-----------------------------------------------------------------------------------------------------------------------
