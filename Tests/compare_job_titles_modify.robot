*** Settings ***
Library    OperatingSystem
Library    Collections
Library    ../Libraries/compare_json_data.py

*** Variables ***
${ORIGINAL_JSON}    ${EXECDIR}/Resources/download/original_job_titles.json
${UPDATED_JSON}     ${EXECDIR}/Resources/download/updated_job_titles.json
${EXPECTED_MODIFIED_TITLE}    Automaton Tester

*** Test Cases ***
Verify Modified Job Title In JSON
    # [Documentation]    Verify that a job title exists with modified data.
    
    # Step 1: Compare the JSON files
    ${differences}=    Compare Job Title Files    ${ORIGINAL_JSON}    ${UPDATED_JSON}
    Log    Differences found: ${differences}    console=True

    # Step 2: Verify 1 job was modified
    ${modified_count}=    Get Length    ${differences['modified']}
    Should Be Equal As Integers    ${modified_count}    1    msg=Expected exactly 1 modified job title

    # Step 3: Verify it's the expected modified job
    List Should Contain Value    ${differences['modified']}    ${EXPECTED_MODIFIED_TITLE}

    # Step 4: Verify nothing was added or removed
    Should Be Empty    ${differences['added']}    msg=No jobs should be added
    Should Be Empty    ${differences['removed']}    msg=No jobs should be removed

*** Keywords ***
Load And Validate Json
    [Arguments]    ${file_path}
    [Documentation]    Load and validate JSON file structure.
    File Should Exist    ${file_path}
    ${data}=    Get File    ${file_path}
    ${json}=    Evaluate    json.loads('''${data}''')    json
    RETURN    ${json}

Compare Job Title Files
    [Arguments]    ${original_path}    ${updated_path}
    [Documentation]    Compare job title JSON files and return differences as a dictionary.
    
    ${original}=    Load And Validate Json    ${original_path}
    ${updated}=    Load And Validate Json    ${updated_path}
    
    # Log    Original JSON: ${original}    console=True
    # Log    Updated JSON: ${updated}    console=True
    
    # Build dictionaries: {Job Titles: job dict}
    ${original_dict}=    Create Dictionary
    FOR    ${job}    IN    @{original}
        ${title}=    Set Variable    ${job['Job Titles']}
        Set To Dictionary    ${original_dict}    ${title}=${job}
    END
    
    ${updated_dict}=    Create Dictionary
    FOR    ${job}    IN    @{updated}
        ${title}=    Set Variable    ${job['Job Titles']}
        Set To Dictionary    ${updated_dict}    ${title}=${job}
    END

    # Find added titles
    ${added}=    Evaluate    list(set(${updated_dict}.keys()) - set(${original_dict}.keys()))
    # Find removed titles
    ${removed}=    Evaluate    list(set(${original_dict}.keys()) - set(${updated_dict}.keys()))

    # Find modified titles (same title but different content)
    ${modified}=    Create List
    FOR    ${title}    IN    @{original_dict.keys()}
        IF    '${title}' in ${updated_dict}
            ${orig_job}=    Get From Dictionary    ${original_dict}    ${title}
            ${updated_job}=    Get From Dictionary    ${updated_dict}    ${title}
            ${are_equal}=    Evaluate    ${orig_job} == ${updated_job}
            IF    not ${are_equal}
                Append To List    ${modified}    ${title}
            END
        END
    END

    &{differences}=    Create Dictionary    added=${added}    removed=${removed}    modified=${modified}
    RETURN    ${differences}
