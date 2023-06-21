*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library     JSONLibrary
Library     DataDriver    ../Resources/DataDriven/GetAllClaims.xlsx    sheet_name = GetAllClaims
Resource       ../Resources/Keyword/CliamSub.robot
Resource       ../Resources/Objects/API_Preferences.robot
#Resource       ../Resources/Keyword/Common_Keywords.robot

Test Template     Get_All_Claims

*** Keywords ***

Get_All_Claims
   [Arguments]         ${URL}       ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Create API session        ${URL}
     Get Request claim        ${sessionName}     ${URI}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}





*** Test Cases ***
${Testcase id} ${Type} ${Desc}


