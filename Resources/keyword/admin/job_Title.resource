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

Input Job_title
    [Arguments]    ${jobTitle}
    Input Text    xpath=(//label[normalize-space(text())='Job Title']/following::input)[1]    ${jobTitle}

Input Job_description
    [Arguments]    ${jobDescript}
    Input Text    xpath=//textarea[@placeholder='Type description here']    ${jobDescript}

Upload files
    [Arguments]    ${uploadFile}
    Wait Until Element Is Visible   xpath=//div[normalize-space(text())='Browse']    timeout=5
    Choose File    xpath=//input[@type='file']   ${uploadFile}

Input Job_note
    [Arguments]    ${note}
    Input Text    xpath=//textarea[@placeholder='Add note']    ${note}

Save button
    Click Element    xpath=//button[contains(.,'Save')]

Save success
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=10

Delete icon
    Click Element    xpath=(//i[@class='oxd-icon bi-trash'])[1]

Edit icon
    Click Element    xpath=(//i[@class='oxd-icon bi-pencil-fill'])[1]

Delete confirmation
    # Wait Until Element Is Visible    xpath=//button[contains(.,'Yes, Delete')]    timeout=5
    Click Element    xpath=//button[contains(.,'Yes, Delete')]




# Get Data From Table
Get Data From Table
    Wait Until Element Is Visible    xpath=//div[@class='oxd-table-body']    timeout=30
    ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
    ${row_count}=    Get Length    ${rows}

    ${headers}=    Get WebElements    css=.oxd-table-header .oxd-table-header-cell
    ${header_list}=    Create List
    FOR    ${header}    IN    @{headers}
        ${text}=    Get Text    ${header}
        log     ${text}
        Append To List    ${header_list}    ${text}
    END
    
    ${get_data_list}=    Create List
    FOR    ${row}    IN RANGE    ${row_count}
        ${cell_data}=    Create Dictionary
        ${checkbox}=    Get text    xpath=(//div[@class='oxd-table-card-cell-checkbox'][1])[${row+1}]
        ${job_title}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][2])[${row+1}]
        ${job_descript}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][3])[${row+1}]
        ${actions}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][4])[${row+1}]
        
        Set To Dictionary    ${cell_data}    ${header_list}[0]=${checkbox}
        Set To Dictionary    ${cell_data}    ${header_list}[1]=${job_title}
        Set To Dictionary    ${cell_data}    ${header_list}[2]=${job_descript}
        Set To Dictionary    ${cell_data}    ${header_list}[3]=${actions}
        
        Append To List    ${get_data_list}    ${cell_data}
    END
    Log    ${get_data_list}
    RETURN    ${get_data_list}
    # Save Data To JSON    ${get_data_list}    ${EXECDIR}/Resources/download/Job_title_list.json