#Feature: Handle user login via the RESTful API
#
#      In order to allow secure access to the system
#      As a client software developer
#      I need to be able to let users log in and out
##-----------------------------------------------------------------------------------------------------------------------
#  Background:
#    Given there are Users with the following details:
#      | id | username | email          | password |
#      | 1  | peter    | peter@test.com | testpass |
#      | 2  | john     | john@test.org  | johnpass |
#    And I set header "Content-Type" with value "application/json"
#
#  Scenario: Can change password with valid credentials
#    When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0MzQyNDYsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzQ3ODQ2In0.ZWMPBoq1ClW447GccsWF1cwS_A02qaQ39U1UHt7jnOcE40hPbvptuNQGFGoS8CDc6l53lvUbdXtYNifD3U8IoXJDp2ROtvBSergNeWUhW5VQtV-Mc8B-7GfMgJRrWhSAPOlnL-FrgXA1urYz902pL7mwBKWGrgc-xxJhD7XPNnHzX2y6CMvH5qh_HQS5wFB80frqB5Hyi6MlLMCoyZDeykcsQybB2KuChtcIjZK1EeGzVtYA5IqZxLqWu4RPOqcqfo0ca_j9-2pWVnC889iWu4jxGju3neGzwz_B5RGq7Vzql81F51h07gZ9aobO6XargRIvXDe4ItbaRZtiuAvf5rwbzdW6SbHuJIDF0K465-9VI6Zt1WwyCie0qB97GTR4RiFQvqZ4CcuNTbsugDLUjwBhxBCIXbhk4gMhq7MTBR1C_DefQ3YEYKTRvgGHzzx50qhUBserJVjhqu_BQg93O7qJNPCJh8ch912CViDMiANR2vs7hUAfhvnJiMcSLtJL75KCW3-uXMBzio-0y5TXB3gHLCL6DdbJD5CQct5lNKYodQ3rZ5vdE7_YAILfEA5fCUck70HQVR9JSMIdCZPwQAY_V8sOyUMwFDAp7z4gpCiNnlsUfn6y_aQ0MknZDmksCPWsxRuBgnIjVTguHjZzpmA9Y613n1e6t4eIXnp1GYs"
#    And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/1/change" with body:
#      """
#      {
#        "current_password": "testpass",
#        "plainPassword": {
#          "first": "new password",
#          "second": "new password"
#        }
#      }
#      """
#    Then the response code should be 200
#    And the response should contain "The password has been changed"
#-----------------------------------------------------------------------------------------------------------------------
#Background:
#Given there are Users with the following details:
#| id | username | email          | password | confirmation_token |
#| 1  | peter    | peter@test.com | testpass |                    |
#| 2  | john     | john@test.org  | johnpass | some-token-string  |
#And I set header "Content-Type" with value "application/json"
#
#Scenario: Cannot hit the change password endpoint if not logged in (missing token)
#When I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/1/change" with body:
#"""
#      {
#        "current_password": "testpass",
#        "plainPassword": {
#          "first": "new password",
#          "second": "new password"
#        }
#      }
#      """
#Then the response code should be 401
#
#Scenario: Cannot change the password for a different user
#When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0Mzc3NzUsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzUxMzc1In0.b7GnAE0GWE_TYSfd6Xq_9ws-Ak7GqNbmFEVe_oSEGeKLHzvuKh0TIHdMLpsIqXtippzSMPW2n4DHAtZzlEn7Zs0OlQySXuECbQ94VkbyupiAeE9PtSyBYBs3t_y_LfR0vBwjOPXigTfnBZq1qjqHguTjq158UNzxgWdj2N1kUbdoaT41TPWDIX5b25CyddrMstUSt1g5XRssI5AZDm9t09SPwD5D8q2JowGpo9IW_3icVQ2pm9bmcZPBo1jPTdPqMFbdS3VZhVYWzWCBqhWNFjpTGdNYEZ_2ymlx91Owo4fPLe9Ht7TICzNUyQCuxSmhtPx6XKUdIIpdMcUJYkX0xV2F3CSB3lGWe4yedE-3vZmi8whkMVSyRzwRxgMY0yY0MReSYb4lQqDvp7uehF4G65c8lDjzZOYyC3n71qfCK92-_RSubHdo9osBvN6GrI-MVSF8l9g1hidcpz67SWm9GoLvRezh7r4xyMJ410r7NqDNZT47F9WJWd7Z3CZ3tuXJP3cS_5WEjwdm4IQUzFjAi6OcCZRwvw5UHbJSzObQNtMhr4IhZNtU-HTkiRhMteucZxBGbE5dS4C2YGS4Vj8CtpDVBMYGDBdbe0wW3s_brTwZgsj4pzt64uAhr_f4izI5rzlBJRTPdpVPRKAiER3brQ55GT-HHPeBD2_CUf8JVA4"
#And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/2/change" with body:
#"""
#      {
#        "current_password": "testpass",
#        "plainPassword": {
#          "first": "new password",
#          "second": "new password"
#        }
#      }
#      """
#Then the response code should be 403
#
#Scenario: Can change password with valid credentials
#When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0Mzc3NzUsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzUxMzc1In0.b7GnAE0GWE_TYSfd6Xq_9ws-Ak7GqNbmFEVe_oSEGeKLHzvuKh0TIHdMLpsIqXtippzSMPW2n4DHAtZzlEn7Zs0OlQySXuECbQ94VkbyupiAeE9PtSyBYBs3t_y_LfR0vBwjOPXigTfnBZq1qjqHguTjq158UNzxgWdj2N1kUbdoaT41TPWDIX5b25CyddrMstUSt1g5XRssI5AZDm9t09SPwD5D8q2JowGpo9IW_3icVQ2pm9bmcZPBo1jPTdPqMFbdS3VZhVYWzWCBqhWNFjpTGdNYEZ_2ymlx91Owo4fPLe9Ht7TICzNUyQCuxSmhtPx6XKUdIIpdMcUJYkX0xV2F3CSB3lGWe4yedE-3vZmi8whkMVSyRzwRxgMY0yY0MReSYb4lQqDvp7uehF4G65c8lDjzZOYyC3n71qfCK92-_RSubHdo9osBvN6GrI-MVSF8l9g1hidcpz67SWm9GoLvRezh7r4xyMJ410r7NqDNZT47F9WJWd7Z3CZ3tuXJP3cS_5WEjwdm4IQUzFjAi6OcCZRwvw5UHbJSzObQNtMhr4IhZNtU-HTkiRhMteucZxBGbE5dS4C2YGS4Vj8CtpDVBMYGDBdbe0wW3s_brTwZgsj4pzt64uAhr_f4izI5rzlBJRTPdpVPRKAiER3brQ55GT-HHPeBD2_CUf8JVA4"
#And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/1/change" with body:
#"""
#      {
#        "current_password": "testpass",
#        "plainPassword": {
#          "first": "new password",
#          "second": "new password"
#        }
#      }
#      """
#Then the response code should be 200
#And the response should contain "change_password.flash.success"
#
#Scenario: Cannot change password with bad current password
#When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0Mzc3NzUsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzUxMzc1In0.b7GnAE0GWE_TYSfd6Xq_9ws-Ak7GqNbmFEVe_oSEGeKLHzvuKh0TIHdMLpsIqXtippzSMPW2n4DHAtZzlEn7Zs0OlQySXuECbQ94VkbyupiAeE9PtSyBYBs3t_y_LfR0vBwjOPXigTfnBZq1qjqHguTjq158UNzxgWdj2N1kUbdoaT41TPWDIX5b25CyddrMstUSt1g5XRssI5AZDm9t09SPwD5D8q2JowGpo9IW_3icVQ2pm9bmcZPBo1jPTdPqMFbdS3VZhVYWzWCBqhWNFjpTGdNYEZ_2ymlx91Owo4fPLe9Ht7TICzNUyQCuxSmhtPx6XKUdIIpdMcUJYkX0xV2F3CSB3lGWe4yedE-3vZmi8whkMVSyRzwRxgMY0yY0MReSYb4lQqDvp7uehF4G65c8lDjzZOYyC3n71qfCK92-_RSubHdo9osBvN6GrI-MVSF8l9g1hidcpz67SWm9GoLvRezh7r4xyMJ410r7NqDNZT47F9WJWd7Z3CZ3tuXJP3cS_5WEjwdm4IQUzFjAi6OcCZRwvw5UHbJSzObQNtMhr4IhZNtU-HTkiRhMteucZxBGbE5dS4C2YGS4Vj8CtpDVBMYGDBdbe0wW3s_brTwZgsj4pzt64uAhr_f4izI5rzlBJRTPdpVPRKAiER3brQ55GT-HHPeBD2_CUf8JVA4"
#And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/1/change" with body:
#"""
#      {
#        "current_password": "wrong",
#        "plainPassword": {
#          "first": "new password",
#          "second": "new password"
#        }
#      }
#      """
#Then the response code should be 400
#And the response should contain "fos_user.current_password.invalid"
#
#Scenario: Cannot change password with mismatched new password
#When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0Mzc3NzUsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzUxMzc1In0.b7GnAE0GWE_TYSfd6Xq_9ws-Ak7GqNbmFEVe_oSEGeKLHzvuKh0TIHdMLpsIqXtippzSMPW2n4DHAtZzlEn7Zs0OlQySXuECbQ94VkbyupiAeE9PtSyBYBs3t_y_LfR0vBwjOPXigTfnBZq1qjqHguTjq158UNzxgWdj2N1kUbdoaT41TPWDIX5b25CyddrMstUSt1g5XRssI5AZDm9t09SPwD5D8q2JowGpo9IW_3icVQ2pm9bmcZPBo1jPTdPqMFbdS3VZhVYWzWCBqhWNFjpTGdNYEZ_2ymlx91Owo4fPLe9Ht7TICzNUyQCuxSmhtPx6XKUdIIpdMcUJYkX0xV2F3CSB3lGWe4yedE-3vZmi8whkMVSyRzwRxgMY0yY0MReSYb4lQqDvp7uehF4G65c8lDjzZOYyC3n71qfCK92-_RSubHdo9osBvN6GrI-MVSF8l9g1hidcpz67SWm9GoLvRezh7r4xyMJ410r7NqDNZT47F9WJWd7Z3CZ3tuXJP3cS_5WEjwdm4IQUzFjAi6OcCZRwvw5UHbJSzObQNtMhr4IhZNtU-HTkiRhMteucZxBGbE5dS4C2YGS4Vj8CtpDVBMYGDBdbe0wW3s_brTwZgsj4pzt64uAhr_f4izI5rzlBJRTPdpVPRKAiER3brQ55GT-HHPeBD2_CUf8JVA4"
#And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/1/change" with body:
#"""
#      {
#        "current_password": "testpass",
#        "plainPassword": {
#          "first": "new password 11",
#          "second": "new password 22"
#        }
#      }
#      """
#Then the response code should be 400
#And the response should contain "fos_user.password.mismatch"
#
#Scenario: Cannot change password with missing new password field
#When I set header "Authorization" with value "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJleHAiOjE1MjA0Mzc3NzUsInVzZXJuYW1lIjoicGV0ZXIiLCJpYXQiOiIxNTIwMzUxMzc1In0.b7GnAE0GWE_TYSfd6Xq_9ws-Ak7GqNbmFEVe_oSEGeKLHzvuKh0TIHdMLpsIqXtippzSMPW2n4DHAtZzlEn7Zs0OlQySXuECbQ94VkbyupiAeE9PtSyBYBs3t_y_LfR0vBwjOPXigTfnBZq1qjqHguTjq158UNzxgWdj2N1kUbdoaT41TPWDIX5b25CyddrMstUSt1g5XRssI5AZDm9t09SPwD5D8q2JowGpo9IW_3icVQ2pm9bmcZPBo1jPTdPqMFbdS3VZhVYWzWCBqhWNFjpTGdNYEZ_2ymlx91Owo4fPLe9Ht7TICzNUyQCuxSmhtPx6XKUdIIpdMcUJYkX0xV2F3CSB3lGWe4yedE-3vZmi8whkMVSyRzwRxgMY0yY0MReSYb4lQqDvp7uehF4G65c8lDjzZOYyC3n71qfCK92-_RSubHdo9osBvN6GrI-MVSF8l9g1hidcpz67SWm9GoLvRezh7r4xyMJ410r7NqDNZT47F9WJWd7Z3CZ3tuXJP3cS_5WEjwdm4IQUzFjAi6OcCZRwvw5UHbJSzObQNtMhr4IhZNtU-HTkiRhMteucZxBGbE5dS4C2YGS4Vj8CtpDVBMYGDBdbe0wW3s_brTwZgsj4pzt64uAhr_f4izI5rzlBJRTPdpVPRKAiER3brQ55GT-HHPeBD2_CUf8JVA4"
#And I send a "POST" request to "http://localhost/api-code-review/web/app_acceptance.php/password/1/change" with body:
#"""
#      {
#        "current_password": "testpass",
#        "plainPassword": {
#          "second": "missing first"
#        }
#      }
#      """
#Then the response code should be 400
#And the response should contain "fos_user.password.mismatch"
