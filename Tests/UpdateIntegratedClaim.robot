*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DataDriver    ../Resources/DataDriven/UpdateIntegratedClaim.xlsx   sheet_name = UpdateIntegratedClaim
Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot


Test Template     Update_Integrated_Claim

*** Keywords ***

Update_Integrated_Claim
    [Arguments]         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Put Request claim        ${sessionName}     ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}



*** Test Cases ***
${Testcase id} ${Type} ${Desc}