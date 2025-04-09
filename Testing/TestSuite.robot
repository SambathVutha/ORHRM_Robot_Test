*** Settings ***
Library           SeleniumLibrary
Library           ../Library/SaveToFile.py
Library           Collections

*** Variables ***
${URL}                      https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}                 Admin
${PASSWORD}                 admin123
${DOWNLOAD_PATH}           ${EXECDIR}/Resources/download/orangehrm_users.json

*** Test Cases ***
Login And Scrape Users
    [Documentation]    Login to OrangeHRM, go to Admin tab, scrape user data and save to JSON
    Open Browser    ${URL}    chrome
    Wait Until Element Is Visible    name=username    timeout=5
    Input Text    name=username    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains Element    xpath=//span[text()='Admin']    timeout=5

    Click Element    xpath=//span[text()='Admin']
    Wait Until Page Contains Element    xpath=//h5[text()='System Users']    timeout=10
    Sleep    2s

    ${rows}=    Get WebElements    xpath=//div[@class='oxd-table-body']//div[@role='row']
    ${row_count}=    Evaluate    len(${rows})
    Log To Console    Found rows: ${row_count}


    ${user_data}=    Create List
    ${row_index}=    Set Variable    1

    FOR    ${row}    IN    @{rows}
        ${cells}=    Execute Javascript    return Array.from(arguments[0].querySelectorAll('div[role="cell"]')).map(cell => cell.innerText);    ${row}
        Log To Console    Row ${row_index}: ${cells}
        Append To List    ${user_data}    ${cells}
        ${row_index}=    Evaluate    ${row_index} + 1
    END

    Log    ${user_data}
    Save Data To JSON    ${user_data}    ${DOWNLOAD_PATH}
    Log To Console    Data saved to ${DOWNLOAD_PATH}

    Close Browser
