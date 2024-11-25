*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DataDriver    ../Resources/DataDriven/CreateIC.xlsx   sheet_name = CreateIC
Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot


Test Template     Create_IC

*** Keywords ***

Create_IC
    [Arguments]         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Post Request claim        ${sessionName}     ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}



*** Test Cases ***
${Testcase id} ${Type} ${Desc}



