*** Settings ***
Library  SeleniumLibrary
Resource    ../../Resources/keyword/login_application.resource

*** Variables ***


*** Test Cases ***
Verify Successful Login to OrangeHRM
    [documentation]  This test case verifies that user is able to successfully Login to OrangeHRM
    [tags]  Smoke
    Start Application
    Validate Login Page
    Logout Application
    Close Application