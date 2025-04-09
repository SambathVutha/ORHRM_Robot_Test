*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource   access_navigation.resource
Library    ../../Library/SaveToFile.py
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py


*** Variables ***
${empusername}
${emppswd}
${firstname}
${middlename}
${lastname}
${employeeid}
${photofile}
${led_date}

*** Keywords ***
Input First_Name
    [Arguments]    ${firstname}
    Wait Until Element Is Visible    name=firstName
    Input Text    name=firstName   ${firstname}

Input Middle_Name
    [Arguments]    ${middlename}
    Input Text    name=middleName    ${middlename}

Input Last_Name
    [Arguments]    ${lastname}
    Input Text    name=lastName    ${lastname}

Input Employee_ID
    [Arguments]    ${employeeid}
    #Wait Until Element Is Enabled    xpath=(//input[@class='oxd-input oxd-input--active'])[2]
    #Clear Element Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]
    Press Keys    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    CONTROL+a    BACKSPACE
    Input Text    xpath=(//label[normalize-space(text())='Employee Id']/following::input)[1]    ${employeeid}

Upload Photo
    [Arguments]    ${photofile}
    Choose File   xpath=//input[@type='file']    ${photofile}

Enable Create_Login_Details
    Click Element    xpath=//input[@type='checkbox']/following-sibling::span[1]

Input EmpUser_Name
    [Arguments]    ${empusername}
    Input Text    xpath=(//label[normalize-space(text())='Username']/following::input)[1]    ${empusername}

Status Enabled
    Wait Until Element Is Enabled     xpath=//input[@type='radio' and @value='1']
    Click Element     xpath=(//span[contains(@class, 'oxd-radio-input')])[1]
    



Status Disabled
    #Click Element    //input[@type='radio' and @value='0']
    #Select Radio Button    (//div[@class='oxd-radio-wrapper'])[2]    Disabled
    #Radio Button Should Be Set To    (//div[@class='oxd-input-group'])[2]    Disabled
    Wait Until Element Is Enabled     xpath=//input[@type='radio' and @value='2']
    Click Element     xpath=(//span[contains(@class, 'oxd-radio-input')])[2]

Input EmpPassword
    [Arguments]    ${emppswd}
    Input Password    xpath=(//input[@type='password'])[1]    ${emppswd}

Input EmpConfirm_Password
    [Arguments]    ${emppswd}
    Input Password    xpath=(//input[@type='password'])[2]    ${emppswd}

Save Employee
    Click Element    xpath=//button[contains(.,'Save')]

Cancel Employee
    Click Element    xpath=//button[contains(.,'Cancel')]


Delete icon
    Click Element    xpath=(//i[@class='oxd-icon bi-trash'])[1]

Edit icon
    Click Element    xpath=(//i[@class='oxd-icon bi-pencil-fill'])[1]

Delete Employee
    Click Element    xpath=//button[contains(.,'Yes, Delete')]

Search button
    Click Element    xpath=//button[@type='submit']

License Expiry Date
    [Arguments]    ${led_date}
    Input Text    xpath=(//i[contains(@class,'oxd-icon bi-calendar')])[1]    ${led_date}

Date of Birth
    [Arguments]    ${dob}
    Input Text    xpath=(//i[contains(@class,'oxd-icon bi-calendar')])[2]    ${dob}


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
    Save Data To JSON    ${user_data}       ${EXECDIR}/Resources/download/Employee_list_users.json
