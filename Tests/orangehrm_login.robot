*** Settings ***
Library    SeleniumLibrary
Library    Process

*** Variables ***
${BROWSER}        headlesschrome
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}       Admin
${PASSWORD}       admin123
${LOG_FILE}       ${EXECDIR}${/}logs${/}execution.log

*** Test Cases ***
OrangeHRM Background Login Test
    [Documentation]    Runs OrangeHRM login in headless mode
    Start Background Login Process
    Verify Successful Login

*** Keywords ***
Start Background Login Process
    # Configure headless Chrome
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${URL}

Login To OrangeHRM
    Input Text    name=username    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Button    css=button.orangehrm-login-button
    Wait Until Page Contains Element    css=.oxd-userdropdown-name    timeout=15

Verify Successful Login
    ${logged_in}=    Run Keyword And Return Status    Page Should Contain Element    css=.oxd-userdropdown-name
    Run Keyword If    ${logged_in}    Log    Login Successful!
    ...    ELSE    Fail    Login Failed!
    Capture Page Screenshot

[Teardown]
    Close Browser