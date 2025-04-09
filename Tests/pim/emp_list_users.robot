*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/access_navigation.resource
Resource    ../../Resources/keyword/employee.resource
Suite Setup    Start Application
Suite Teardown    Close Application
Library    ../../.venv/Lib/site-packages/robot/libraries/String.py


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
    PIM Navigation
    Get list users