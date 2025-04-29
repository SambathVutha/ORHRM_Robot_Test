*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${BROWSER}        Chrome
${URL}            https://opensource-demo.orangehrmlive.com
${LOGIN URL}      ${URL}/web/index.php/auth/login
${ADMIN URL}      ${URL}/web/index.php/admin/viewSystemUsers
${JOB URL}        ${URL}/web/index.php/admin/viewPayGrades
${USERNAME}       Admin
${PASSWORD}       admin123
${PAY GRADE NAME}    None
${CURRENCY}       United States Dollar
${MIN SALARY}     5000
${MAX SALARY}     10000

*** Test Cases ***
Add New Pay Grade in OrangeHRM
    Open Browser To Login Page
    Login To OrangeHRM
    Navigate To Pay Grades
    Add Pay Grade
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10

Login To OrangeHRM
    Input Text    name=username    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Button    css=button.orangehrm-login-button
    Wait Until Page Contains Element    css=.oxd-userdropdown-name    timeout=15

Navigate To Pay Grades
    Click Element    css=.oxd-sidepanel li:nth-child(1)  # Admin menu
    Wait Until Element Is Visible    css=.oxd-topbar-body-nav li:nth-child(2)    timeout=10
    Click Element    css=.oxd-topbar-body-nav li:nth-child(2)  # Job menu
    Wait Until Element Is Visible    css=.oxd-topbar-body-nav ul li:nth-child(3)    timeout=10
    Click Element    css=.oxd-topbar-body-nav ul li:nth-child(3)  # Pay Grades
    Wait Until Page Contains    Add Pay Grade    timeout=15

Add Pay Grade
    # Generate random pay grade name
    ${RANDOM NUM}=    Generate Random String    4    [NUMBERS]
    ${RANDOM NUM}=    Generate Random String    4    [NUMBERS]
    ${PAY GRADE NAME}=    Set Variable    Grade RF-${RANDOM NUM}
    
    # Click Add button
    Click Button    css=button.oxd-button--secondary
    
    # Fill pay grade form
    Wait Until Element Is Visible    name=name    timeout=10
    Input Text    name=name    ${PAY GRADE NAME}
    
    # Click Save button
    Click Button    css=button[type='submit']
    
    # Add currency
    Wait Until Page Contains    Add Currency    timeout=10
    Click Button    css=.oxd-button--secondary
    
    # Select currency
    Wait Until Element Is Visible    css=.oxd-select-text-input    timeout=10
    Click Element    css=.oxd-select-text-input
    Input Text    css=.oxd-select-text-input    ${CURRENCY}
    Press Keys    css=.oxd-select-text-input    RETURN
    
    # Input salary range
    Input Text    css=.oxd-grid-item:nth-child(1) input    ${MIN SALARY}
    Input Text    css=.oxd-grid-item:nth-child(2) input    ${MAX SALARY}
    
    # Save currency
    Click Button    css=button[type='submit']
    
    # Verify success
    Wait Until Page Contains    ${PAY GRADE NAME}    timeout=15
    Log    Successfully added Pay Grade: ${PAY GRADE NAME}