*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${job_title}    IT Testing01
${job_descript}    IT Manager description
${UPLOAD_FILE}   ${EXECDIR}/Resources/upload/job-description.pdf
${note}    Job title note


*** Test Cases ***
Add New_Job Title
    Validate Login Page
    Add job title    ${job_title}    ${job_descript}    ${UPLOAD_FILE}    ${note}
    Capture Page Screenshot    filename=../Screenshots/add_job_title.png
    Logout Application
    Close Application


*** Keywords ***
Add job title
    [Arguments]    ${job_title}    ${job_descript}    ${UPLOAD_FILE}    ${note}
    Admin Navigation
    Job Navigation
    Job Titles Navigation
    Button Add Job Title
    Input Job Title    ${job_title}
    Input Job Description    ${job_descript}
    Upload files    ${UPLOAD_FILE}
    Input Job Note    ${note}
    Save button
    Save success job title
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



    
