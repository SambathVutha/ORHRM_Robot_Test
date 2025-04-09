*** Settings ***
Library    SeleniumLibrary
Library    ../../.venv/Lib/site-packages/robot/libraries/String.py
Resource    access_navigation.resource
Library    ../../Library/SaveToFile.py
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py

*** Variables ***
${username}
${role}
${name}
${status}
${password}
${boder_color}
${download_path}=    ${CURDIR}${/}Downloads${/}


*** Keywords ***
Select User_role
    [Arguments]    ${role}
    Wait Until Element Is Enabled    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]    timeout=5
    #Select From List By Label    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]    ${role}
    Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]
    Wait Until Element Is Enabled    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]   timeout=5
    #Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-up-fill')])
    #Select From List By Index    xpath=//div[normalize-space(text())='Admin']    1
    Click Element    xpath=(//div[@role='option'])[2]


Input Employee_name
    [Arguments]    ${name}
    Input Text    xpath=//input[@placeholder='Type for hints...']    ${name}
    Wait Until Element Is Enabled    xpath=//*[@class="oxd-autocomplete-option"]    timeout=5
    Click Element    xpath=//*[@class="oxd-autocomplete-option"]
    #Press Keys    xpath=//input[@placeholder='Type for hints...']   CONTROL+a    BACKSPACE    ${name} 

Select Status
    [Arguments]    ${status}
    Wait Until Element Is Enabled    xpath=(//div[@class='oxd-select-text oxd-select-text--active'])[2]    timeout=5
    Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[3]
    Wait Until Element Is Enabled    xpath=//i[contains(@class,'oxd-icon bi-caret-up-fill')]   timeout=5
    Click Element    xpath=(//div[@class='oxd-select-option'])[2]

Input Name_User    
    [Arguments]    ${username}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${username}

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
#     IF    ${}
        
#     END
# ${property}=    Get WebElement    ${locator}
#     ${value}=    Call Method    ${property}    value_of_css_property    ${css_property}
    
    
# Save success
#     [Arguments]    ${save success}
#     Wait Until Element Is Visible    xpath=//div[@class='oxd-toast-content']    timeout=5

Var_username
    ${test}=   Generate Random String    2    [NUMBERS]
    RETURN    ${test}


Get list users
    Wait Until Element Is Enabled    xpath=//div[@class='oxd-table-body']    timeout=5
    ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
    ${user_data}=    Create List
    FOR    ${row}    IN    @{rows}
        ${cells}=    Get WebElements    xpath=.//div[@role='cell']
        # ${cells}=    Execute Javascript    return Array.from(arguments[0].querySelectorAll('div[role="cell"]')).map(cell => cell.innerText);    ${row}
        ${cell_texts}=    Create List
        FOR    ${cell}    IN    @{cells}
            ${text}=    Get Text    ${cell}
            Append To List    ${cell_texts}    ${text}
        END
        # Run Keyword If    '${cell_texts}' != '[]'    Append To List    ${user_data}    ${cell_texts}
        # Run Keyword If    ${cell_texts}    Append To List    ${user_data}    ${cell_texts}
        Append To List    ${user_data}    ${cell_texts}

    END
    Log    ${user_data}
    Save Data To JSON    ${user_data}       ${EXECDIR}/Resources/download/Admin_list_users.json
