*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
# Resource    ../../Resources/keyword/admin.resource
Resource    ../../Resources/keyword/admin/job_Title.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${jobTitle}    IT Testing010
${jobDescript}    IT Manager description
${uploadFile}   ${EXECDIR}/Resources/upload/job-description.pdf
${note}    Job title note


*** Test Cases ***
Add New_Job Title
    Validate Login Page
    Add job title    ${jobTitle}    ${jobDescript}    ${uploadFile}    ${note}
    Logout Application
    Close Application

   
*** Keywords ***
Add job title
    [Arguments]    ${jobTitle}    ${jobDescript}    ${uploadFile}    ${note}
    Admin Navigation
    Job Navigation
    Job Titles Navigation
    Button Add
    Input Job Title    ${jobTitle}
    Input Job Description    ${jobDescript}
    Upload files    ${uploadFile}
    Input Job Note    ${note}
    Save button
    Save success
    ${data_table}=    Get Data From Table
    Save Data To JSON    ${data_table}    ${EXECDIR}/Resources/download/Add_data2table.json



    