*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
#Left Navigation
Dashboard Navigation
    Click Element    //span[text()='Dashboard']


#Admin Navigation
Admin Navigation
    Click Element    //span[text()='Admin']

User Management Navigation
    Click Element    //span[text()='User Management']

Users Navigation
    Click Element    //span[text()='Users']

Job Navigation
    Click Element    (//i[@class='oxd-icon bi-chevron-down'])[2]

Job Titles Navigation
    Click Element    //a[normalize-space(text())='Job Titles']

Pay Grades Navigation
    Click Element    //a[normalize-space(text())='Pay Grades']

Employment Status Navigation
    Click Element    //a[normalize-space(text())='Employment Status']

Job Categories Navigation
    Click Element    //span[text()='Job Categories']

Work Shifts Navigation
    Click Element    //a[normalize-space(text())='Work Shifts']

Organization Navigation
    Click Element    (//i[@class='oxd-icon bi-chevron-down'])[3]

Locations Navigation
    Click Element    //a[normalize-space(text())='Locations']



#PIM Navigation
PIM Navigation
    Click Element    (//li[@class='oxd-main-menu-item-wrapper'])[2]
#//li[contains(.,'PIM')]

Employee List Navigation
    Click Element    //span[text()='Employee List']

Add Employee Navigation
    Click Element    //a[normalize-space(text())='Add Employee']

Reports Navigation
    Click Element    //span[text()='Reports']
    