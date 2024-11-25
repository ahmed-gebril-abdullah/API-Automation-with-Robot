*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DataDriver    ../Resources/DataDriven/ClaimSubmission.xlsx    sheet_name=ClaimSubmission
Resource       ../Resources/Objects/API_Preferences.robot


Test Template     Create_Claim

*** Keywords ***

Create_Claim
    [Arguments]         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Post Request claim        ${sessionName}     ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}



*** Test Cases ***         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}

verify create claim     [Tags]    smoke    regression


