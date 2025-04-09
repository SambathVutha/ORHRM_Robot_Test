*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/access_navigation.resource
Resource    ../../Resources/keyword/employee.resource
Suite Setup    Start Application
Suite Teardown    Close Application
Library    ../../.venv/Lib/site-packages/robot/libraries/String.py

*** Variables ***
${empusername}    Admin2
${emppswd}    admin12345
${firstname}    EmpUserName
${middlename}    EmpMiddleName
${lastname}    EmpLastName
${employeeid}    123456
${photofile}    C:/Python312/Robot_Framework/OHRM_project/Resources/upload/profile.png

${test}

*** Test Cases ***
Add New_Employee
    Validate Login Page
    Add Employee
    Capture Page Screenshot    filename=../Screenshots/add_Employee.png
    Logout Application
    Close Application

*** Keywords ***
Add Employee
    Set Selenium Speed    0.5
    PIM Navigation
    add_Employee Navigation
    Wait Until Element Is Enabled    //h6[text()='Add Employee']    timeout=5
    Upload Photo  ${photofile}
    Input First_Name  ${firstname}
    Input Middle_Name  ${middlename}
    Input Last_Name  ${lastname}
    Input Employee_id  ${employeeid}

    #Enable Create_Login_Details
    #Input EmpUser_Name  ${empusername}
    #Status Enabled
    #Status Disabled
    #Input EmpPassword  ${emppswd}
    #Input EmpConfirm_Password  ${emppswd}
    Save Employee


# Create Login Details
#     Enable Create_Login_Details
#     Input EmpUser_Name  ${empusername}
#     Status Enabled
#     Input EmpPassword  ${emppswd}
#     Input EmpConfirm_Password  ${emppswd}
#     Save Employee