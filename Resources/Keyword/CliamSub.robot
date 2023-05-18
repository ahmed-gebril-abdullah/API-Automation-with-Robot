*** Settings ***
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library    JSONLibrary
Library           DateTime
Resource     ../Objects/API_Preferences.robot
Resource       ../Keyword/Common_Keywords.robot
*** Variables ***

*** Keywords ***


Post Request claim
    [Arguments]       ${sessionName}   ${Url}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
#     Update json unique values                       ${Quote_body}     ${Quote_RandomData}
     Post Request using data Driven Structure        ${sessionName}    ${Url}      ${body}     ${StatusCode}
     Verify API Response                             ${actual}      ${Expected}

#Post Request claim
#    [Arguments]       ${sessionName}   ${Quote_Url}     ${Quote_body}    ${Quote_StatusCode}   ${Quote_actual}     ${Quote_Expected}    ${Quote_RandomData}
#     Update json unique values                       ${Quote_body}     ${Quote_RandomData}
#     Post Request using data Driven Structure        ${sessionName}    ${Quote_Url}      ${data}      ${Quote_StatusCode}
#     Verify API Response                             ${Quote_actual}      ${Quote_Expected}



Verify API Response
    [Documentation]    veriy actual resutls
    [Arguments]           ${actual}      ${Expected}
    should be equal as strings    ${actualResult${actual}}    ${Expected}    ignore_case=True


    set test variable             ${proposalNumber}         ${actualResult["getProposalsResponse"]["proposalResponse"]["proposalInfo"][0]["proposalNumber"]}
    log   ${proposalNumber}

#    set test variable             ${QRequestReferenceNo}         ${actualResult["RequestReferenceNo"]}
#    log   ${QRequestReferenceNo}
#
#    set test variable             ${QuotationReferenceNo}        ${actualResult["QuotationDetails"]["QuotationReferenceNo"]}
#    log   ${QuotationReferenceNo}
#
#    set test variable             ${PolicyEffectiveDate}        ${actualResult["QuotationDetails"]["PolicyEffectiveDate"]}
#    log   ${PolicyEffectiveDate}

Update json unique values
   [Arguments]       ${body}    ${RandomData}
    ${data}    to json        ${body}
    ${RequestReferenceNo}     run keyword and return status     SHOULD CONTAIN       ${RandomData}       RequestReferenceNo
    run keyword if    "${RequestReferenceNo}" == "True"   run keyword    update json with random RequestReferenceNo     ${data}

    ${PolicyEffectiveDate}     run keyword and return status     SHOULD CONTAIN       ${RandomData}       PolicyEffectiveDate
   run keyword if    "${PolicyEffectiveDate}" == "True"   run keyword    update json with current date +1    ${data}
   set test variable    ${data}

    ${PolicyEffectiveDatePN}     run keyword and return status     SHOULD CONTAIN       ${RandomData}       PolicyEffectiveDatePN
   run keyword if    "${PolicyEffectiveDatePN}" == "True"   run keyword    update json with current date +1 Policy    ${data}
   set test variable    ${data}

    ${PolicyDateMilliseconds}     run keyword and return status     SHOULD CONTAIN       ${RandomData}       PolicyDateMilliseconds
   run keyword if    "${PolicyDateMilliseconds}" == "True"   run keyword    update json with current date+1_milliseconds    ${data}
   set test variable    ${data}


update json with random RequestReferenceNo
    [Arguments]      ${data}
    ${randomNumber}     generate random string          7  [NUMBERS]
    ${RequestReferenceNo}       Catenate    ${randomNumber}
    log     ${RequestReferenceNo}
    ${data}    jsonlibrary.update value to json    ${data}    RequestReferenceNo    ${RequestReferenceNo}
    set test variable    ${data}
    [Return]      ${data}



update json with current date +1
    [Arguments]      ${data}
    ${Date+1}    get current date    increment=48h    result_format=%d/%m/%Y
    log     ${Date+1}
    ${data}    jsonlibrary.update value to json    ${data}    QuotationDetails.PolicyEffectiveDate   ${Date+1}
    set test variable    ${data}
    [Return]      ${data}


update json with current date +1 Policy
    [Arguments]      ${data}
    ${Date+1}    get current date    increment=48h    result_format=%d/%m/%Y
    log     ${Date+1}
    ${data}    jsonlibrary.update value to json    ${data}    Policy.PolicyEffectiveDate   ${Date+1}
    set test variable    ${data}
    [Return]      ${data}



update json with current date+1_milliseconds
    [Arguments]      ${data}
    ${Date+1ms}     Evaluate  int(round((time.time()+24*3600))*1000)  time
    set test variable      ${DateFormat}    /Date(${Date+1ms})/
    ${data}    jsonlibrary.update value to json    ${data}    Details.PolicyEffectiveDate   ${DateFormat}
    set test variable    ${data}
    log          ${data}
    [Return]      ${data}





