*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***


*** Test Cases ***
List Users
    Validate Login Page
    Get List Users to CSV
    Logout Application
    Close Application


*** Keywords ***
Get List Users to CSV
    # Set Selenium Speed    0.5
    Admin Navigation
    Get list users