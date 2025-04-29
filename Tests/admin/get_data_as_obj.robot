*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${job_title}    IT Testing02
${job_descript}    IT Manager description
${UPLOAD_FILE}   ${EXECDIR}/Resources/upload/job-description.pdf
${note}    Job title note


*** Test Cases ***
Add New_Job Title
    Validate Login Page
    Add job title    ${job_title}    ${job_descript}    ${UPLOAD_FILE}    ${note}
    # Capture Page Screenshot    filename=../Screenshots/add_job_title.png
    Logout Application
    Close Application


*** Keywords ***
Add job title
    [Arguments]    ${job_title}    ${job_descript}    ${UPLOAD_FILE}    ${note}
    Admin Navigation
    Job Navigation
    Job Titles Navigation
    # Button Add Job Title
    # Input Job Title    ${job_title}
    # Input Job Description    ${job_descript}
    # Upload files    ${UPLOAD_FILE}
    # Input Job Note    ${note}
    # Save button
    # Save success job title
    ${job_title_data}=    Get User Table Data
    # ${headers}=    Get Table Data As Arrays
    # ${data_table}=    Get Table Data As Objects    ${headers}

# Get User Table Data
#     Wait Until Element Is Enabled    xpath=//div[@class='oxd-table-body']    timeout=5
#     ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
#     ${user_data}=    Create Dictionary
    
#     FOR    ${row}    IN    @{rows}
#         ${cells}=    Get WebElements    xpath=.//div[@role='cell']
#         ${cell_texts}=    Create Dictionary
        
#         FOR    ${cell}    IN    @{cells}
#             ${text}=    Get Text    ${cell}
#             Set To Dictionary    ${cell_texts}    ${text}    ${text}
#         END
        
#         Set To Dictionary    ${user_data}    ${row}    ${cell_texts}
#     END
    
#     Log    ${user_data}
#     Save Data To JSON    ${user_data}    ${EXECDIR}/Resources/download/Job_title_list.json


Get Table Data As Arrays
    # Get table headers
    ${headers}=    Get WebElements    css=.oxd-table-header .oxd-table-header-cell
    ${header_list}=    Create List
    FOR    ${header}    IN    @{headers}
        ${text}=    Get Text    ${header}
        log     ${text}
        Append To List    ${header_list}    ${text}
    END
    Log    ${header}
    Log    ${text}
    Log    ${header_list}
    Save Data To JSON    ${header_list}    ${EXECDIR}/Resources/download/Job_title_header.json


# Get Table Data As Objects
#     [Arguments]    ${header_list}
#     ${table_data}=    Create List
#     ${rows}=    Get WebElements    css=.oxd-table-body .oxd-table-row
#     FOR    ${row}    IN    @{rows}
#         ${cells}=    Get WebElements    xpath=.//div[contains(@class, 'oxd-table-cell')]
#         ${row_dict}=    Create Dictionary
#         FOR    ${i}    IN RANGE    len(${header_list})
#             ${text}=    Get Text    ${cells[${i}]}
#             Set To Dictionary    ${row_dict}    ${header_list[${i}]}    ${text}
#         END
#         Append To List    ${table_data}    ${row_dict}
#     END
#     RETURN    ${table_data}


Get User Table Data
    [Documentation]    Gets user table data and saves as JSON
    Wait Until Element Is Visible    xpath=//div[@class='oxd-table-body']    timeout=30
    ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
    ${row_count}=    Get Length    ${rows}
    # Get headers of the table
    ${headers}=    Get WebElements    css=.oxd-table-header .oxd-table-header-cell
    ${header_list}=    Create List
    FOR    ${header}    IN    @{headers}
        ${text}=    Get Text    ${header}
        log     ${text}
        Append To List    ${header_list}    ${text}
    END
    Log    ${header_list}[0]
    Log    ${header_list}[1]
    Log    ${header_list}[2]
    Log    ${header_list}[3]

    ${user_data_list}=    Create List
    FOR    ${row}    IN RANGE    ${row_count}
        ${cell_data}=    Create Dictionary
        ${checkbox}=    Get text    xpath=(//div[@class='oxd-table-card-cell-checkbox'][1])[${row+1}]
        ${job_title}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][2])[${row+1}]
        ${job_descript}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][3])[${row+1}]
        ${actions}=    Get Text    xpath=(//div[contains(@class, 'oxd-table-cell')][4])[${row+1}]
        
        # Set To Dictionary    ${cell_data}    Checkbox=${checkbox}
        # Set To Dictionary    ${cell_data}    Job title=${job_title}
        # Set To Dictionary    ${cell_data}    Job description=${job_descript}
        # Set To Dictionary    ${cell_data}    Actions=${actions}

        Set To Dictionary    ${cell_data}    ${header_list}[0]=${checkbox}
        Set To Dictionary    ${cell_data}    ${header_list}[1]=${job_title}
        Set To Dictionary    ${cell_data}    ${header_list}[2]=${job_descript}
        Set To Dictionary    ${cell_data}    ${header_list}[3]=${actions}
        
        Append To List    ${user_data_list}    ${cell_data}
    END
    
    Log    ${user_data_list}
    Save Data To JSON    ${user_data_list}    ${EXECDIR}/Resources/download/Job_title_list03.json
    # Save Data To JSON    ${user_data_list}    ${EXECDIR}/Resources/download/User_list.json


# Save Data To JSON
#     [Arguments]    ${data}    ${file_path}
#     ${json_string}=    Evaluate    json.dumps($data, indent=4)    json
#     Create File    ${file_path}    ${json_string}

# Get User Table Data
#     [Documentation]    Gets user table data and saves as JSON
#     Wait Until Element Is Visible    xpath=//div[@class='oxd-table-body']    timeout=30
#     ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
#     ${row_count}=    Get Length    ${rows}
#     Log    Found ${row_count} rows in table
    
#     ${user_data_list}=    Create List
#     FOR    ${row}    IN    @{rows}
#         ${cell_data}=    Create Dictionary
#         ${job_title}=    Get Text    ${row}.//div[contains(@class, 'oxd-table-cell')][2]
#         ${job_descript}=    Get Text    ${row}.//div[contains(@class, 'oxd-table-cell')][3]
#         ${actions}=    Get Text    ${rows}.//div[contains(@class, 'oxd-table-cell')][4]

#         # ${job_descript}=    Get Text    ${row}(//div[contains(@class, 'oxd-table-cell')][3])
#         # ${actions}=    Get Text    ${row}(//div[contains(@class, 'oxd-table-cell')][4])
        
#         Set To Dictionary    ${cell_data}    Job title=${job_title}
#         Set To Dictionary    ${cell_data}    Job description=${job_descript}
#         Set To Dictionary    ${cell_data}    Actions=${actions}
        
#         Append To List    ${user_data_list}    ${cell_data}
#     END

#     Log    Collected ${row_count} items: ${user_data_list}
#     Save Data To JSON    ${user_data_list}    ${EXECDIR}/Resources/download/Job_title_list01.json
#     Set Test Variable    ${user_data_list}