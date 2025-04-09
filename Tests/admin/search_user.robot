*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Suite Setup    Start Application
Suite Teardown    Close Application
*** Variables ***
${username}    Admin

*** Test Cases ***
Search for Admin
    Validate Login Page
    Search_for_admin
    Logout Application
    Close Application


*** Keywords ***
Search_for_admin
    Admin Navigation
    # User Management Navigation
    # Users Navigation
    Input Name_User  ${username}
    Search button
    Capture Page Screenshot    filename=../Screenshots/admin_search.png
