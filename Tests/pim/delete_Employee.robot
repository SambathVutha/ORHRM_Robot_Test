*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/access_navigation.resource
Resource    ../../Resources/keyword/employee.resource
Suite Setup    Start Application
Suite Teardown    Close Application

*** Variables ***
${employeeid}    0397


*** Test Cases ***
Delete Employee
    Validate Login Page
    Search_Employee
    Delete TheEmployee
    Set Selenium Timeout    5
    Capture Page Screenshot    filename=../Screenshots/delete_Employee.png
    Logout Application
    Close Application

*** Keywords ***
Search_Employee
    PIM Navigation
    Input Employee_id  ${employeeid}
    Search button

Delete TheEmployee
    Set Selenium Speed    0.5
    # PIM Navigation
    # Input Employee_id  ${employeeid}
    Wait Until Element Is Enabled    //*[@class="orangehrm-container"]    timeout=5
    Delete icon
    Delete Employee
