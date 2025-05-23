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
    Delete job title
    Close Application

   
*** Keywords ***
Delete job title
    Admin Navigation
    Job Navigation
    Job Titles Navigation
    Delete icon
    Delete confirmation
    ${data_table}=    Get Data From Table
    Save Data To JSON    ${data_table}    ${EXECDIR}/Resources/download/Delete_data2table.json



    