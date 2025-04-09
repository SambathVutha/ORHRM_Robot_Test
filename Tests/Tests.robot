*** Settings ***
Resource    ../Resources/keyword/login_application.resource
Resource    ../Resources/keyword/admin.resource
Library    ../Library/DemoLibrary.py
Suite Setup    Start Application
# Suite Teardown    Close Application


*** Variables ***
# ${URL}   https://opensource-demo.orangehrmlive.com/web/index.php/api/v2/admin/users

*** Test Cases ***
Add New_User
    Validate Login Page
    Add User

*** Keywords ***
Add User
    Set Selenium Speed    0.5
    Admin Navigation
    Get Responce   ${URL}