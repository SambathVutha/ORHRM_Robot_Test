*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${shift_name}    full_time shift
${from_time}    08:30
${to_time}    18:00
${assigned_emp}    ${CURDIR}${/}Resources${/}data${/}assigned_emp.json

*** Test Cases ***
Add New_Job Title
    Set Selenium Speed    0.5s
    Validate Login Page
    Add New Work Shift
    Capture Page Screenshot    # filename=../Screenshots/add_job_title.png
    Logout Application
    Close Application


*** Keywords ***
Add New Work Shift
    [Documentation]    Add new work shift
    [Tags]    add_work_shift
    Admin Navigation
    Job Navigation
    Work Shifts Navigation
    Button Add Work Shifts
    Input Shift name    ${shift_name}
    Input From Times    ${from_time}
    Input To Times    ${to_time}
    # Input Assigned Employee    ${assigned_emp}
    Save button work shifts
    Save success work shifts

    # ${data_table}=    Get Data From Table

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
    # Log    Collected ${user_data_list}  # Shows complete list
    Log    ${get_data_list}
    Save Data To JSON    ${get_data_list}    ${EXECDIR}/Resources/download/Job_title_list.json



    
