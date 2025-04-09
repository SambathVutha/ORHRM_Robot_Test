*** Settings ***
Library    SeleniumLibrary
Resource    ../../Resources/globle_variable.resource
*** Variables ***
${VALID USER}    Admin
${VALID PASSWORD}    admin123

*** Keywords ***
Start Application
    Open Browser    ${URL}    ${BROWSER}
    #Maximize Browser Window
    Set Selenium Speed   0.5
    #Wait Until Element Is Visible  name:username     timeout=5

Close Application
    Close Browser

Validate Login Page
    Wait Until Element Is Visible  name:username     timeout=5
    Input Username  ${VALID USER}
    Input Psswords  ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    name: username    ${username}

Input Psswords
    [Arguments]    ${password}
    Input Password    name: password    ${password}

Submit Credentials
    Click Element    //button[contains(@class,'oxd-button oxd-button--medium')]

Welcome Page Should Be Open
    Wait Until Element Is Visible  //span[text()='Dashboard']    timeout=15s

Logout Application
    Click Element  //*[@class='oxd-userdropdown']
    Click Element  //a[normalize-space(text())='Logout']
