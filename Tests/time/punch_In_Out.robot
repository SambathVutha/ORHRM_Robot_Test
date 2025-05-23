*** Settings ***
Resource    ../../../Resources/keyword/login_application.resource
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${date}    2023-10-01
${time}    10:00 AM
${note}    Test note


*** Test Cases ***
Add Punch In Out
    Validate Login Page
    Punch In Out
    Logout Application
    Close Application



*** Keywords ***
Punch In Out
    Navigation time
    Navigation Attendance
    Sub Navigation Punch In/Out
    Input date    ${date}
    Input time    ${time}
    Input Note    ${note}
    Button In
    


Navigation time
    Click Element    xpath=//span[text()='Time']

Navigation Attendance
    Click Element    xpath=(//i[@class='oxd-icon bi-chevron-down'])[2]

Sub Navigation Punch In/Out
    Click Element    xpath=//a[normalize-space(text())='Punch In/Out']

Input date
    [Arguments]    ${date}
    Wait Until Element Is Visible   xpath=//input[@placeholder='yyyy-dd-mm']    timeout=5s
    Click Element    xpath=//input[@placeholder='yyyy-dd-mm']    
    Press Keys    xpath=//input[@placeholder='yyyy-dd-mm']    ${date}    ENTER

Input time
    [Arguments]    ${time}
    Wait Until Element Is Visible    xpath=//input[@placeholder='Select Date']    timeout=5s
    Click Element    xpath=//i[contains(@class,'oxd-icon bi-clock')]


Input Note
    [Arguments]    ${note}
    Input Text    xpath=//textarea[@placeholder='Type here']    ${note}   

Button In
    Click Element    xpath=//button[@type='submit']