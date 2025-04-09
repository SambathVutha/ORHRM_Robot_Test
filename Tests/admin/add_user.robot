*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${username}    Admin
${role}    Admin
${name}    EmpUserName
${status}    Enabled
${password}    admin12345


*** Test Cases ***
Add New_User
    Validate Login Page
    Add User
    Capture Page Screenshot    filename=../Screenshots/add_user.png
    Logout Application
    Close Application


*** Keywords ***
Add User
    Set Selenium Speed    0.5
    Admin Navigation
    Button Add
    Wait Until Element Is Enabled    //label[normalize-space(text())='User Role']    timeout=5
    Select User_role  ${role}
    Input Employee_name  ${name}
    Select Status   ${status}
    ${VT}=    Var_username
    Input Name_User     ${username}${VT}
    Input User_password  ${password}
    Input Confirm_password  ${password}
    Save button