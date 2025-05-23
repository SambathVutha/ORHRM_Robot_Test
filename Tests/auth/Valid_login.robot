*** Settings ***
Library  SeleniumLibrary
Resource    ../../Resources/keyword/login_application.resource

*** Variables ***


*** Test Cases ***
Verify Successful Login to OrangeHRM
    [documentation]  This test case verifies that user is able to successfully Login to OrangeHRM
    [tags]  Smoke
    Start Application
    # Start Headless Browser
    Validate Login Page
    Logout Application
    Close Application

*** Keywords ***
Start Headless Browser
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    
    Create WebDriver    Chrome    options=${options}
    Go To    ${URL}
    Set Selenium Implicit Wait    5