*** Settings ***
Library    SeleniumLibrary
Library    ../../.venv/Lib/site-packages/robot/libraries/String.py
Resource    access_navigation.resource
Library    ../../Libraries/SaveToFile.py
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py

*** Variables ***
${username}
${role}
${name}
${status}
${password}
${boder_color}
${download_path}=    ${CURDIR}${/}Downloads${/}
${job_title}
${job_descript}
${UPLOAD_FILE}
${note}
${save success}
${emp_status}


*** Keywords ***
# Add admin user
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
    
Save success
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=5

Var_username
    ${test}=   Generate Random String    2    [NUMBERS]
    RETURN    ${test}


# Get list users
#     Wait Until Element Is Enabled    xpath=//div[@class='oxd-table-body']    timeout=5
#     ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
#     ${user_data}=    Create List
#     FOR    ${row}    IN    @{rows}
#         ${cells}=    Get WebElements    xpath=.//div[@role='cell']
#         # ${cells}=    Execute Javascript    return Array.from(arguments[0].querySelectorAll('div[role="cell"]')).map(cell => cell.innerText);    ${row}
#         ${cell_texts}=    Create List
#         FOR    ${cell}    IN    @{cells}
#             ${text}=    Get Text    ${cell}
#             Append To List    ${cell_texts}    ${text}
#         END
#         # Run Keyword If    '${cell_texts}' != '[]'    Append To List    ${user_data}    ${cell_texts}
#         # Run Keyword If    ${cell_texts}    Append To List    ${user_data}    ${cell_texts}
#         Append To List    ${user_data}    ${cell_texts}

#     END
#     Log    ${user_data}
#     Save Data To JSON    ${user_data}       ${EXECDIR}/Resources/download/Admin_list_users.json

# Job title
Button Add Job Title
    Click Element    xpath=//button[contains(.,'Add')]

Input Job_title
    [Arguments]    ${job_title}
    Input Text    xpath=(//label[normalize-space(text())='Job Title']/following::input)[1]    ${job_title}

Input Job_description
    [Arguments]    ${job_descript}
    Input Text    xpath=//textarea[@placeholder='Type description here']    ${job_descript}

Upload files
    [Arguments]    ${UPLOAD_FILE}
    Wait Until Element Is Visible   xpath=//div[normalize-space(text())='Browse']    timeout=5
    Choose File    xpath=//input[@type='file']   ${UPLOAD_FILE}

Input Job_note
    [Arguments]    ${note}
    Input Text    xpath=//textarea[@placeholder='Add note']    ${note}

Save button job title
    Click Element    xpath=//button[contains(.,'Save')]

Save success job title
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=5


#Pay grades
Button Add Pay Grades
    Click Element    xpath=//button[contains(.,'Add')]

Input Pay Grade
    [Arguments]    ${pay_grade}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${pay_grade}

Button Add Currency
    # Wait Until Element Is Visible    xpath=//button[contains(.,'Add')]    timeout=50
    Wait Until Page Contains    Currencies    timeout=10
    Click Element    xpath=//button[contains(.,'Add')]

Input Currency
    [Arguments]    ${currency}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${currency}

Select Currency
    [Arguments]    ${currency}
    # Wait Until Element Is Visible    xpath=//div[@class='oxd-select-text oxd-select-text--active']   timeout=30
    # Wait Until Element Is Visible    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]   timeout=30
    # Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]
    # Wait Until Element Is Enabled    xpath=(//div[@class='oxd-input-group__label-wrapper']/following-sibling::div)[2]   timeout=30
    # Click Element    xpath=(//div[@class='oxd-select-option'])[2]
    # Select From List By Value    xpath=//*[@class="oxd-select-dropdown --positon-bottom"]    ${currency}

    # Wait Until Element Is Enabled    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]    timeout=5
    # Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]
    # Wait Until Element Is Enabled    xpath=//i[contains(@class,'oxd-icon bi-caret-up-fill')]   timeout=5
    # Click Element    xpath=(//div[@class='oxd-select-option'])[2]
    # Input Text    xpath=//*[@class="oxd-select-dropdown --positon-bottom"]    ${currency}
    # Press Keys    xpath=//*[@class="oxd-select-dropdown --positon-bottom"]    ENTER

    # Wait Until Element Is Visible    css=.oxd-select-text-input    timeout=10
    # Click Element    css=.oxd-select-text-input
    # Input Text    css=.oxd-select-text-input    ${currency}
    # Press Keys    css=.oxd-select-text-input    RETURN

    Wait Until Element Is Enabled    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]    timeout=5
    Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]
    Wait Until Element Is Enabled    xpath=//i[contains(@class,'oxd-icon bi-caret-up-fill')]   timeout=5
    Input Text    css=.oxd-select-text-input    ${currency}
    Press Keys    css=.oxd-select-text-input    RETURN
    

Input Minimum Salary
    [Arguments]    ${min_salary}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[3]    ${min_salary}

Input Maximum Salary
    [Arguments]    ${max_salary}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[4]    ${max_salary}

Save button pay grades
    Click Element    xpath=//button[contains(.,'Save')]

Save success pay grades
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=10

# Employee status
Button Add Employment Status
    Click Element    xpath=//button[contains(.,'Add')]

Input Employment Status
    [Arguments]    ${status}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${emp_status}

Save button employment status
    Click Element    xpath=//button[contains(.,'Save')]

Save success employment status
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=5

# work shifts
Button Add Work Shifts
    Click Element    xpath=//button[contains(.,'Add')]

Input Shift name
    [Arguments]    ${shift_name}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${shift_name}

Input from times
    [Arguments]    ${from_time}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[3]    ${from_time}

Input to times
    [Arguments]    ${to_time}
    Wait Until Element Is Enabled    xpath=(//input[@class='oxd-input oxd-input--active'])[4]    timeout=5
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[4]    ${to_time}

Input assigned employee
    [Arguments]    ${assigned_emp}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[5]    ${assigned_emp}
    Wait Until Element Is Enabled    xpath=//div[@class='oxd-autocomplete-option']    timeout=5
    Click Element    xpath=//div[@class='oxd-autocomplete-option']
    # Press Keys    xpath=//input[@placeholder='Type for hints...']   CONTROL+a    BACKSPACE    ${assigned_emp}
    # Press Keys    xpath=//input[@placeholder='Type for hints...']   ${assigned_emp}    RETURN

Save button work shifts
    Click Element    xpath=//button[contains(.,'Save')]

Save success work shifts
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=5