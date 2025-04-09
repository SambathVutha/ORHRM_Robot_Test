*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/employee.resource
Suite Setup    Start Application
Suite Teardown    Close Application
*** Variables ***
${employeeid}    0312

*** Test Cases ***
Search for Employee
    Validate Login Page
    Search_Employee
    Logout Application
    Close Application


*** Keywords ***
Search_Employee
    PIM Navigation
    # User Management Navigation
    # Users Navigation
    Input Employee_id  ${employeeid}
    Search button
    Capture Page Screenshot    filename=../Screenshots/admin_search.png
