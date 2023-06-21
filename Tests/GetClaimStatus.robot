*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DataDriver    ../Resources/DataDriven/GetClaimStatus.xlsx    sheet_name = GetClaimStatus
Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot

#Resource       ../Resources/Keyword/Common_Keywords.robot

Test Template     Get_Claim_Status

*** Keywords ***

Get_Claim_Status
    [Arguments]         ${URL}       ${URI}       ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Get Request claim        ${sessionName}     ${URI}        ${StatusCode}   ${actual}     ${Expected}    ${RandomData}




*** Test Cases ***
${Testcase id} ${Type} ${Desc}


