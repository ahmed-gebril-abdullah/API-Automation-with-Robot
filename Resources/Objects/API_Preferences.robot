*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     BuiltIn
Library     Collections
Library     String
Library    JSONLibrary


*** Variables ***


*** Keywords ***

Create API session
    [Arguments]          ${Base_Url}
    ${randomNumber}      generate random string          4    [NUMBERS]
    ${sessionName}       Catenate    session_${randomNumber}            disable_warnings=1
    set global variable     ${sessionName}
    create session           ${sessionName}     ${Base_Url}              timeout=30     disable_warnings=1

#Create API session
#    [Arguments]          ${Base_Url}   ${auth_username}    ${auth_password}
#    ${randomNumber}      generate random string          4    [NUMBERS]
#    ${sessionName}       Catenate    session_${randomNumber}
#    set global variable     ${sessionName}
#    ${auth}   create list   ${auth_username}   ${auth_password}
#    create session           ${sessionName}     ${Base_Url}       auth=${auth}       timeout=30     disable_warnings=1


Post Request and check response
    [Arguments]    ${sessionName}  ${SecondUrl}       ${body}      ${statuscode}
    ${header}=  Create Dictionary   Content-Type=application/json
    ${resp}     Post request           ${sessionName}         ${SecondUrl}    ${body}    headers=${header}
    set test variable   ${actualResult}      ${resp.json()}
    should be equal as strings             ${resp.status_code}         ${statuscode}
    set test variable     ${actualResult}

Post Request claim
    [Arguments]       ${sessionName}   ${Url}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
#     Update json unique values                       ${Quote_body}     ${Quote_RandomData}
     Post Request using data Driven Structure        ${sessionName}    ${Url}      ${body}     ${StatusCode}
     Verify API Response                             ${actual}      ${Expected}

Get Request claim
    [Arguments]       ${sessionName}   ${Url}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
     Get Request using data Driven Structure        ${sessionName}    ${Url}      ${body}     ${StatusCode}
     Verify API Response                             ${actual}      ${Expected}

#Post Request claim
#    [Arguments]       ${sessionName}   ${Quote_Url}     ${Quote_body}    ${Quote_StatusCode}   ${Quote_actual}     ${Quote_Expected}    ${Quote_RandomData}
#     Update json unique values                       ${Quote_body}     ${Quote_RandomData}
#     Post Request using data Driven Structure        ${sessionName}    ${Quote_Url}      ${data}      ${Quote_StatusCode}
#     Verify API Response                             ${Quote_actual}      ${Quote_Expected}

Put Request claim
    [Arguments]       ${sessionName}   ${Url}     ${body}    ${StatusCode}   ${actual}     ${Expected}    ${RandomData}
#     Update json unique values                       ${Quote_body}     ${Quote_RandomData}
     Put Request using data Driven Structure        ${sessionName}    ${Url}      ${body}     ${StatusCode}
     Verify API Response                             ${actual}      ${Expected}


Verify API Response
    [Documentation]    veriy actual resutls
    [Arguments]           ${actual}      ${Expected}
    should be equal as strings    ${actualResult${actual}}    ${Expected}    ignore_case=True




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








#Creat API session using Data Driven
#    [Arguments]    ${Base_Url}  ${auth_username}    ${auth_password}
#    ${randomNumber}      generate random string          4    [NUMBERS]
#    ${sessionName}       Catenate    session_${randomNumber}
#    set global variable      ${sessionName}
##    ${proxies} 	Create Dictionary	http=http://88.85.228.248:3128
#    ${auth}   create list    ${auth_username}    ${auth_password}
#    create session      ${sessionName}       ${Base_Url}          auth=${auth}      timeout=30    max_retries=2      disable_warnings=1
#    [Return]      ${sessionName}

Post Request using data Driven Structure
    [Documentation]    Post request with DataDriven structure
    [Arguments]     ${sessionName}     ${URI}     ${data}    ${statuscode}
    ${headers}=  Create Dictionary   Content-Type=application/json
    ${resp}       post request       ${sessionName}          ${URI}      ${data}     headers=${headers}     timeout=10
    status should be                 ${statuscode}           ${resp}
    ${actualResult}          to json        ${resp.content}
    set test variable       ${actualResult}


Get Request using data Driven Structure
    [Documentation]    Get request with DataDriven structure
    [Arguments]     ${sessionName}     ${URI}       ${statuscode}
    ${headers}=  Create Dictionary   Content-Type=application/json
    ${resp}       get request       ${sessionName}          ${URI}      headers=${headers}     timeout=10
    status should be                 ${statuscode}           ${resp}
    ${actualResult}          to json        ${resp.content}
    set test variable       ${actualResult}

#Post Request using data Driven Structure
#    [Documentation]    Post request with DataDriven structure
#    [Arguments]     ${sessionName}     ${URI}     ${data}    ${statuscode}
#    ${headers}=  Create Dictionary   Content-Type=application/json
#    ${resp}       post request       ${sessionName}          ${URI}      ${data}     headers=${headers}     timeout=10
#    status should be                 ${statuscode}           ${resp}
#    ${actualResult}          to json        ${resp.content}
#    set test variable       ${actualResult}
#

Put Request using data Driven Structure
    [Documentation]    Put request with DataDriven structure
    [Arguments]     ${sessionName}     ${URI}     ${data}    ${statuscode}
    ${headers}=  Create Dictionary   Content-Type=application/json
    ${resp}       Put request       ${sessionName}          ${URI}      ${data}     headers=${headers}     timeout=10
    status should be                 ${statuscode}           ${resp}
    ${actualResult}          to json        ${resp.content}
    set test variable       ${actualResult}


