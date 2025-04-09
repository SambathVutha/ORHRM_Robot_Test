*** Settings ***
Library  SeleniumLibrary
Resource    ../../Resources/keyword/login_application.resource

*** Variables ***


*** Test Cases ***
Verify Successful Login to OrangeHRM
    Given Open Browser to Login Page
    When User Iputs valid "Admin" and "admin123"
    Then Welcome Page Should Be Open
    And Logout from Application
    

*** Keywords ***
Open Browser to Login Page
    Start Application

User Iputs valid "${username}" and "${password}"
  Validate Login Page

Logout from Application
    Logout Application
    Close Application