*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DataDriver    ../Resources/DataDriven/UpdateClaim.xlsx   sheet_name=UpdateClaim
Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot


Test Template     Update_Claim

*** Keywords ***

Update_Claim
    [Arguments]         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Put Request claim        ${sessionName}     ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}



*** Test Cases ***
${Testcase id} ${Type} ${Desc}


