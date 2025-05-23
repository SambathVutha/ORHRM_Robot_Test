*** Settings ***
Library    SeleniumLibrary
Library    ../../../.venv/Lib/site-packages/robot/libraries/DateTime.py
Resource    ../access_navigation.resource
Library    ../../../Libraries/SaveToFile.py
Library    ../.venv/Lib/site-packages/robot/libraries/Collections.py

*** Variables ***


*** Keywords ***
Button Add
    Click Element    xpath=//button[contains(.,'Add')]

Input Loc_Name    [Arguments]    ${name}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[2]    ${name}

Input City    [Arguments]    ${city}
    Input Text    xpath=(//input[@class='oxd-input oxd-input--active'])[3]    ${city}

Select Loc_Country    [Arguments]    ${country}
    Wait Until Element Is Visible    xpath=(//div[@class='oxd-select-text oxd-select-text--active'])    timeout=10
    Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[2]
    Wait Until Element Is Enabled    xpath=//i[contains(@class,'oxd-icon bi-caret-up-fill')]   timeout=5
    # Click Element    xpath=(//div[@class='oxd-select-option'])[15]
    Click Element    xpath=//div[@role='option']//span[contains(text(),'${country}')]




    # List Selection Should Be  id:dropdown  Option 1
    # Select From List By Value  id:dropdown  2
    # List Selection Should Be  id:dropdown  Option 2

    # Wait Until Element Is Enabled    xpath=(//div[@class='oxd-select-text oxd-select-text--active'])[2]    timeout=5
    # Click Element    xpath=(//i[contains(@class,'oxd-icon bi-caret-down-fill')])[3]
    # Wait Until Element Is Enabled    xpath=//i[contains(@class,'oxd-icon bi-caret-up-fill')]   timeout=5
    # Click Element    xpath=(//div[@class='oxd-select-option'])[2]

    # Handle country dropdown
    # Click Element    xpath=//label[contains(text(),'Country')]/following::div[contains(@class,'oxd-select-wrapper')][1]
    # Wait Until Element Is Visible    xpath=//div[@role='listbox']
    # Click Element    xpath=//div[@role='option']//span[contains(text(),'${country}')]

Save button
    Click Element    xpath=//button[contains(.,'Save')]

Save success
    Wait Until Element Is Visible    xpath=//div[contains(., 'Successfully Saved')]    timeout=10

Button Search
    Click Element    xpath=//button[contains(.,'Search')]

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
        ${name}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][2])[${row+1}]
        ${city}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][3])[${row+1}]
        ${country}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][4])[${row+1}]
        ${Phone}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][5])[${row+1}]
        ${num_of_emp}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][6])[${row+1}]
        ${actions}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][7])[${row+1}]
        
        Set To Dictionary    ${cell_data}    ${header_list}[0]=${checkbox}
        Set To Dictionary    ${cell_data}    ${header_list}[1]=${name}
        Set To Dictionary    ${cell_data}    ${header_list}[2]=${city}
        Set To Dictionary    ${cell_data}    ${header_list}[3]=${country}
        Set To Dictionary    ${cell_data}    ${header_list}[4]=${country}
        Set To Dictionary    ${cell_data}    ${header_list}[5]=${num_of_emp}
        Set To Dictionary    ${cell_data}    ${header_list}[6]=${actions}
        
        Append To List    ${get_data_list}    ${cell_data}
    END
    Log    ${get_data_list}
    RETURN    ${get_data_list}
    # Save Data To JSON    ${get_data_list}    ${EXECDIR}/Resources/download/Job_title_list.json