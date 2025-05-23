*** Settings ***
Library    OperatingSystem
Library    Collections
Library    ../Libraries/compare_json_data.py

*** Variables ***
${ORIGINAL_JSON}    ${EXECDIR}/Resources/download/original_job_titles.json
${UPDATED_JSON}     ${EXECDIR}/Resources/download/updated_job_titles.json
${NEW_JOB_TITLE}    Automaton Tester
${EXPECTED_REMOVED_TITLE}    Automaton Tester

*** Test Cases ***
Verify Added Job Title In JSON
     [Documentation]    Verify that the expected job title was removed and no other changes were made.
    
    # Step 1: Compare the JSON files
    ${differences}=    Compare Job Title Files    ${ORIGINAL_JSON}    ${UPDATED_JSON}
    Log    Differences found: ${differences}    console=True

    # Step 2: Verify 1 job was removed
    ${removed_count}=    Get Length    ${differences['removed']}
    Should Be Equal As Integers    ${removed_count}    1    msg=Expected exactly 1 removed job title

    # Step 3: Verify it's the expected job title
    List Should Contain Value    ${differences['removed']}    ${EXPECTED_REMOVED_TITLE}

    # Step 4: Verify nothing was added or modified
    Should Be Empty    ${differences['added']}    msg=No jobs should be added
    Should Be Empty    ${differences['modified']}    msg=No existing jobs should be modified

*** Keywords ***
Load And Validate Json
    [Arguments]    ${file_path}
    [Documentation]    Load and validate JSON file structure
    File Should Exist    ${file_path}
    ${data}=    Get File    ${file_path}
    ${json}=    Evaluate    json.loads('''${data}''')    json
    RETURN    ${json}

# Compare Job Title Files
#     [Arguments]    ${original_path}    ${updated_path}
#     [Documentation]    Compare job title JSON files and return differences as a dictionary
    
#     ${original}=    Load And Validate Json    ${original_path}
#     ${updated}=    Load And Validate Json    ${updated_path}
    
#     # Extract job titles from both JSON files
#     ${original_titles}=    Create List
#     FOR    ${job}    IN    @{original}
#         Append To List    ${original_titles}    ${job['Job Title']}
#     END
    
#     ${updated_titles}=    Create List
#     FOR    ${job}    IN    @{updated}
#         Append To List    ${updated_titles}    ${job['Job Title']}
#     END
    
#     # Find added and removed titles
#     ${added}=    Evaluate    list(set(${updated_titles}) - set(${original_titles}))
#     ${removed}=    Evaluate    list(set(${original_titles}) - set(${updated_titles}))
    
#     # Check for modified entries (this is a placeholder; real logic can be added)
#     ${modified}=    Create List    # Empty list for now; customize if needed
    
#     &{differences}=    Create Dictionary    added=${added}    removed=${removed}    modified=${modified}
    
#     RETURN    ${differences}

Compare Job Title Files
    [Arguments]    ${original_path}    ${updated_path}
    [Documentation]    Compare job title JSON files and return differences as a dictionary
    
    ${original}=    Load And Validate Json    ${original_path}
    ${updated}=    Load And Validate Json    ${updated_path}
    
    Log    Original JSON: ${original}    console=True
    Log    Updated JSON: ${updated}    console=True
    
    ${original_titles}=    Create List
    FOR    ${job}    IN    @{original}
        Log    Job item: ${job}    console=True
        Append To List    ${original_titles}    ${job['Job Titles']}
    END
    
    ${updated_titles}=    Create List
    FOR    ${job}    IN    @{updated}
        Log    Job item: ${job}    console=True
        Append To List    ${updated_titles}    ${job['Job Titles']}
    END
    
    ${added}=    Evaluate    list(set(${updated_titles}) - set(${original_titles}))
    ${removed}=    Evaluate    list(set(${original_titles}) - set(${updated_titles}))
    
    ${modified}=    Create List    # Empty for now
    
    &{differences}=    Create Dictionary    added=${added}    removed=${removed}    modified=${modified}
    
    RETURN    ${differences}


