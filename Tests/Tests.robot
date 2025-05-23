*** Settings ***
Library    OperatingSystem
Library    Collections
Resource    ../resources/keyword/compare_json_data.resource

*** Variables ***
${UPDATED_JSON}     ${EXECDIR}/Resources/download/Admin_list_users02.json
${JOB_TITLE_TO_CHECK}    Jobinsam@6742

*** Test Cases ***
Check If Job Title Was Added
    # [Documentation]    Check if a specific job title is present in the updated JSON file and log the result.
    
    # Step 1: Load the JSON file
    ${job_titles}=    Get All Job Titles    ${UPDATED_JSON}
    # Log    All job titles: ${job_titles}    console=True

    # Step 2: Check if the specific title is in the list
    Run Keyword If    '${JOB_TITLE_TO_CHECK}' in ${job_titles}
    ...    Log    '${JOB_TITLE_TO_CHECK}' was added successfully.    console=True
    ...  ELSE
    ...    Log    '${JOB_TITLE_TO_CHECK}' was NOT found in the updated JSON.    console=True
