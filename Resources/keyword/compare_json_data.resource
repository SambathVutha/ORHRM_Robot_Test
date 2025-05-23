*** Settings ***
Library    OperatingSystem
Library    Collections

*** Keywords ***
Load And Validate Json
    [Arguments]    ${file_path}
    [Documentation]    Load and validate JSON file structure.
    File Should Exist    ${file_path}
    ${data}=    Get File    ${file_path}
    ${json}=    Evaluate    json.loads('''${data}''')    json
    RETURN    ${json}

Get All Job Titles
    [Arguments]    ${json_file}
    [Documentation]    Extracts a list of job titles from the JSON file.
    ${json_data}=    Load And Validate Json    ${json_file}
    ${titles}=    Create List
    FOR    ${job}    IN    @{json_data}
        Append To List    ${titles}    ${job['Country']}
    END
    RETURN    ${titles}
