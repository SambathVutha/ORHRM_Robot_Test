*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
# Resource    ../../Resources/keyword/admin.resource
Resource    ../../Resources/keyword/admin/job_Title.resource
Library    JSONLibrary
Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***


*** Test Cases ***
Add New_Job Title
    Validate Login Page
    Edit job title
    Logout Application
    Close Application

   
*** Keywords ***
Edit job title
    Admin Navigation
    Job Navigation
    Job Titles Navigation
    Edit icon
    Input Job Title     edited
    Save button
    # Save success
    ${data_table}=    Get Data From Table
    Save Data To JSON    ${data_table}    ${EXECDIR}/Resources/download/Edit_data2table.json



    