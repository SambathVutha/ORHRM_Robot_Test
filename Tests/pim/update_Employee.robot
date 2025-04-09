*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/access_navigation.resource
Resource    ../../Resources/keyword/employee.resource
Suite Setup    Start Application
Suite Teardown    Close Application

*** Variables ***
${employeeid}    0427
${led_date}    2024-12-31
${dob}    1990-01-01


*** Test Cases ***
Update Employee
    Validate Login Page
    Search_Employee
    Update Employee
    Capture Page Screenshot    filename=../Screenshots/Update_Employee.png
    Logout Application
    Close Application

*** Keywords ***
Search_Employee
    PIM Navigation
    Input Employee_id  ${employeeid}
    Search button
    Edit icon

Update Employee
    Set Selenium Speed    0.5
    Wait Until Element Is Enabled    //h6[text()='Personal Details']    timeout=5
    License Expiry Date    ${led_date}
    Date of Birth    ${dob}
    Save Employee