*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***


*** Test Cases ***
List Users
    Validate Login Page
    Admin Navigation
    ${data_table}=    Get Data From Table
    Logout Application
    Close Application


*** Keywords ***
Get Data From Table
    # Wait Until Element Is Enabled    xpath=//div[@class='oxd-table-body']    timeout=5
    # ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
    # ${user_data}=    Create List
    
    # FOR    ${row}    IN    @{rows}
    #     ${cells}=    Get WebElements    xpath=.//div[@role='cell']
    #     ${cell_texts}=    Create List
        
    #     FOR    ${cell}    IN    @{cells}
    #         ${text}=    Get Text    ${cell}
    #         Append To List    ${cell_texts}    ${text}
    #     END
        
    #     Append To List    ${user_data}    ${cell_texts}
    # END
    
    # Log    ${user_data}
    # Save Data To JSON    ${user_data}    ${EXECDIR}/Resources/download/Admin_list_users.json


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
        ${username}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][2])[${row+1}]
        ${user_role}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][3])[${row+1}]
        ${emp_name}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][4])[${row+1}]
        ${status}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][5])[${row+1}]
        ${actions}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][6])[${row+1}]
        
        Set To Dictionary    ${cell_data}    ${header_list}[0]=${checkbox}
        Set To Dictionary    ${cell_data}    ${header_list}[1]=${username}
        Set To Dictionary    ${cell_data}    ${header_list}[2]=${user_role}
        Set To Dictionary    ${cell_data}    ${header_list}[3]=${emp_name}
        Set To Dictionary    ${cell_data}    ${header_list}[4]=${status}
        Set To Dictionary    ${cell_data}    ${header_list}[5]=${actions}
        
        Append To List    ${get_data_list}    ${cell_data}
    END
    # Log    Collected ${user_data_list}  # Shows complete list
    Log    ${get_data_list}
    Save Data To JSON    ${get_data_list}    ${EXECDIR}/Resources/download/Admin_list_users02.json