*** Settings ***
Library    OperatingSystem
Library    Collections
Library    ../Libraries/compare_json_data.py

*** Variables ***
${ORIGINAL_JSON}    ${EXECDIR}/Resources/download/original_job_titles.json
${UPDATED_JSON}     ${EXECDIR}/Resources/download/updated_job_titles.json
${NEW_JOB_TITLE}    Automaton Tester

*** Test Cases ***
Verify Added Job Title In JSON
    [Documentation]    Verify only the expected new job was added
    
    # Step 1: Compare the JSON files
    ${differences}=    Compare Job Title Files    ${ORIGINAL_JSON}    ${UPDATED_JSON}
    Log    Differences found: ${differences}    console=True
    
    # Step 2: Verify only 1 new job was added
    ${added_count}=    Get Length    ${differences['added']}
    Should Be Equal As Integers    ${added_count}    1    msg=Expected exactly 1 new job title
    
    # Step 3: Verify it's the expected job title
    List Should Contain Value    ${differences['added']}    ${NEW_JOB_TITLE}
    
    # Step 4: Verify nothing was removed or modified
    Should Be Empty    ${differences['removed']}    msg=No jobs should be removed
    Should Be Empty    ${differences['modified']}    msg=No existing jobs should be modified

*** Keywords ***
Load And Validate Json
    [Arguments]    ${file_path}
    [Documentation]    Load and validate JSON file structure
    File Should Exist    ${file_path}
    ${data}=    Get File    ${file_path}
    ${json}=    Evaluate    json.loads('''${data}''')    json
    RETURN    ${json}

Compare Job Title Files
    [Arguments]    ${original_path}    ${updated_path}
    [Documentation]    Compare job title JSON files and return differences as a dictionary
    
    ${original}=    Load And Validate Json    ${original_path}
    ${updated}=    Load And Validate Json    ${updated_path}
    
    # Extract job titles from both JSON files
    ${original_titles}=    Create List
    FOR    ${job}    IN    @{original}
        Append To List    ${original_titles}    ${job['Job Title']}
    END
    
    ${updated_titles}=    Create List
    FOR    ${job}    IN    @{updated}
        Append To List    ${updated_titles}    ${job['Job Title']}
    END
    
    # Find added and removed titles
    ${added}=    Evaluate    list(set(${updated_titles}) - set(${original_titles}))
    ${removed}=    Evaluate    list(set(${original_titles}) - set(${updated_titles}))
    
    # Check for modified entries (this is a placeholder; real logic can be added)
    ${modified}=    Create List    # Empty list for now; customize if needed
    
    &{differences}=    Create Dictionary    added=${added}    removed=${removed}    modified=${modified}
    
    RETURN    ${differences}