*** Settings ***
Library    SeleniumLibrary
Library    ../../../.venv/Lib/site-packages/robot/libraries/DateTime.py
Resource    ../access_navigation.resource
Library    ../../../Library/SaveToFile.py
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py

*** Variables ***


*** Keywords ***
Button Add
    Click Element    xpath=//button[contains(.,'Add')]

Input Employment Status
    [Arguments]    ${emp_status}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${emp_status}

Save button
    Click Element    xpath=//button[contains(.,'Save')]

Save success
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=5