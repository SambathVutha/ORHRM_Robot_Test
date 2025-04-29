*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${pay_grade}    Grade 08
${currency}    KHR - Kampuchean Riel
${min_salary}    100
${max_salary}    1000

*** Test Cases ***
Add New_Job Title
    Set Selenium Speed    0.3
    Validate Login Page
    Add pay grade    ${pay_grade}
    Add Currency    ${currency}
    # Capture Page Screenshot    filename=../Screenshots/add_job_title.png
    Logout Application
    Close Application


*** Keywords ***
Add pay grade
    [Arguments]    ${pay_grade}
    Admin Navigation
    Job Navigation
    Pay Grades Navigation
    Button Add Pay Grades
    Input Pay Grade    ${pay_grade}
    Save button pay grades
    # Save success pay grades
    # Button Add Currency
    # Select Currency    ${currency}
    # Input Minimum Salary    ${min_salary}
    # Input Maximum Salary    ${max_salary}
    # ${data_table}=    Get Data From Table

Add Currency
    [Arguments]    ${currency}
    Button Add Currency
    Select Currency    ${currency}
    Input Minimum Salary    ${min_salary}
    Input Maximum Salary    ${max_salary}
    Save button pay grades
    Save success pay grades

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

    

    
