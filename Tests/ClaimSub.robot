*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary

Library     DataDriver    ../Resources/DataDriven/ClaimSubmission.xlsx   sheet_name=ClaimSubmission

Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot
Resource       ../Resources/Keyword/Common_Keywords.robot

Test Template     Tawuniya_CreatePolicy_Quotes




*** Keywords ***

Tawuniya_CreatePolicy_Quotes
    [Arguments]    ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create ICS session         ${URL}
     Post Request claim          ${sessionName}   ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}



*** Test Cases ***

${Testcase id} ${Type} ${Desc}


