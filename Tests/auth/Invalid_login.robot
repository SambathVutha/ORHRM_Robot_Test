*** Settings ***
Suite Setup       Start Application
Suite Teardown    Close Application
Test Template     Login With Invalid Credentials Should Fail
Resource          ../../Resources/keyword/login_application.resource


*** Test Cases ***               USER NAME        PASSWORD
Invalid Username                 invalid          ${VALID PASSWORD}
Invalid Password                 ${VALID USER}    invalid
Invalid Username And Password    invalid          whatever
Empty Username                   ${EMPTY}         ${VALID PASSWORD}
Empty Password                   ${VALID USER}    ${EMPTY}
Empty Username And Password      ${EMPTY}         ${EMPTY}




*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Enabled    name:username    timeout=5
    Input Username    ${username}
    Input Psswords    ${password}
    Submit Credentials
    Login Should Have Failed
    
Login Should Have Failed
    Title Should Be    OrangeHRM