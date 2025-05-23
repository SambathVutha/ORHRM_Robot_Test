*** Settings ***
Resource    ../../Resources/keyword/login_application.resource
Resource    ../../Resources/keyword/admin.resource
Resource    ../../../Resources/keyword/admin/locations.resource
Resource    ../../Resources/keyword/compare_json_data.resource
Library    JSONLibrary
# Library    OperatingSystem
Suite Setup    Start Application
Suite Teardown    Close Application


*** Variables ***
${name}    Mirzo
${city}    Tashkent
${country}    Canada
${UPDATED_JSON}     ${EXECDIR}/Resources/download/Original_data_files.json
${DATA_TO_CHECK}    Canada

*** Test Cases ***
Search Locations
    Validate Login Page
    Search Locations        ${name}    ${city}    ${country}
    
    ${job_titles}=    Get All Job Titles    ${UPDATED_JSON}
    Run Keyword If    '${DATA_TO_CHECK}' in ${job_titles}
    ...    Log    '${DATA_TO_CHECK}' was added successfully.    console=True
    ...  ELSE
    ...    Log    '${DATA_TO_CHECK}' was NOT found in the updated JSON.    console=True
    
    # Capture Page Screenshot    filename=../Screenshots/Search_locations.png
    Logout Application
    Close Application


*** Keywords ***
Search Locations
    [Arguments]    ${name}    ${city}    ${country}
    Admin Navigation
    Organization Navigation
    Locations Navigation
    ${data_table}=    Get Data From Table
    Save Data To JSON    ${data_table}    ${EXECDIR}/Resources/download/Original_data_files.json
    # Input Loc_Name    ${name}
    # Input City    ${city}
    Select Loc_Country      ${country}
    Button Search
    # ${data_table}=    Get Data From Table
    ${data_table}=    Get Data From Table
    Save Data To JSON    ${data_table}    ${EXECDIR}/Resources/download/Search_data_files.json


    

    
