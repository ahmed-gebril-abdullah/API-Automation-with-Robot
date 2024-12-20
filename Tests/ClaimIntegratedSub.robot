*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DatabaseLibrary
Library     DataDriver    ../Resources/DataDriven/ClaimSubmissionIntegrated.xlsx    sheet_name = ClaimSubmissionIntegrated
Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot
#Resource       ../Resources/Keyword/Common_Keywords.robot
Resource       ../Keyword/CliamSub.robot





Test Template     Create_Claim

*** Keywords ***


Create_Claim
    [Arguments]         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Post Request claim        ${sessionName}     ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}




*** Test Cases ***
${Testcase id} ${Type} ${Desc}


