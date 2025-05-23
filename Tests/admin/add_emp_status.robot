*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${emp_status}    Freelance-Full Time

*** Test Cases ***
Add New_Job Title
    Validate Login Page
    Add Emp Status    ${emp_status}
    # Capture Page Screenshot    filename=../Screenshots/add_job_title.png
    Logout Application
    Close Application


*** Keywords ***
Add Emp Status
    [Arguments]    ${emp_status}
    Admin Navigation
    Job Navigation
    Employment Status Navigation
    Button Add Employment Status
    Input Employment Status    ${emp_status}
    Save button employment status
    Save success employment status
    ${data_table}=    Get Data From Table

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
        ${empt_status}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][2])[${row+1}]
        ${actions}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][3])[${row+1}]
        
        Set To Dictionary    ${cell_data}    ${header_list}[0]=${checkbox}
        Set To Dictionary    ${cell_data}    ${header_list}[1]=${empt_status}
        Set To Dictionary    ${cell_data}    ${header_list}[2]=${actions}
        
        Append To List    ${get_data_list}    ${cell_data}
    END
    # Log    Collected ${user_data_list}  # Shows complete list
    Log    ${get_data_list}
    Save Data To JSON    ${get_data_list}    ${EXECDIR}/Resources/download/Employment_datas.json

    

    
