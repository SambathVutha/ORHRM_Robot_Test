*** Settings ***
Library    SeleniumLibrary
Library    ../../../.venv/Lib/site-packages/robot/libraries/DateTime.py
Resource    ../access_navigation.resource
Library    ../../../Library/SaveToFile.py
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py

*** Variables ***


*** Keywords ***
Select User_role
    [Arguments]    ${role}
    Wait Until Element Is Enabled    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]    timeout=5
    Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]
    Wait Until Element Is Enabled    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]   timeout=5
    Click Element    xpath=(//div[@role='option'])[2]

Input Employee_name
    [Arguments]    ${empName}
    Input Text    xpath=//input[@placeholder='Type for hints...']    ${empName}
    Wait Until Element Is Enabled    xpath=//*[@class="oxd-autocomplete-option"]    timeout=5
    Click Element    xpath=//*[@class="oxd-autocomplete-option"]

Select Status
    [Arguments]    ${status}
    Wait Until Element Is Enabled    xpath=(//div[@class='oxd-select-text oxd-select-text--active'])[2]    timeout=5
    Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[3]
    Wait Until Element Is Enabled    xpath=//i[contains(@class,'oxd-icon bi-caret-up-fill')]   timeout=5
    Click Element    xpath=(//div[@class='oxd-select-option'])[2]

Input Name_User    
    [Arguments]    ${userName}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${userName}

Input User_password
    [Arguments]    ${password}
    Input Password   xpath=(//input[@type='password'])[1]    ${password}

Input Confirm_password
    [Arguments]    ${password}
    Input Password   xpath=(//input[@type='password'])[2]    ${password}

Search button
    Click Element    xpath=//button[@type='submit']

Button Add
    Click Element    xpath=//button[contains(.,'Add')]

Save button
    Click Element    xpath=//button[contains(.,'Save')]
    
Save success
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=5