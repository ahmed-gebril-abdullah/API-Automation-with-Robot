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
    ${sessionName}       Catenate    session_${randomNumber}
    set global variable     ${sessionName}
    create session           ${sessionName}     ${Base_Url}              timeout=30     disable_warnings=1

#Create API session
    #[Arguments]          ${Base_Url}   ${auth_username}    ${auth_password}
    #${randomNumber}      generate random string          4    [NUMBERS]
    #${sessionName}       Catenate    session_${randomNumber}
   # set global variable     ${sessionName}
  #  ${auth}   create list   ${auth_username}   ${auth_password}
 #   create session           ${sessionName}     ${Base_Url}       auth=${auth}       timeout=30     disable_warnings=1


Post Request and check response
    [Arguments]    ${sessionName}  ${SecondUrl}       ${body}      ${statuscode}
    ${header}=  Create Dictionary   Content-Type=application/json
    ${resp}     Post request           ${sessionName}         ${SecondUrl}    ${body}    headers=${header}
    set test variable   ${actualResult}      ${resp.json()}
    should be equal as strings             ${resp.status_code}         ${statuscode}
    set test variable     ${actualResult}

Creat API session using Data Driven
    [Arguments]    ${Base_Url}
    ${randomNumber}      generate random string          4    [NUMBERS]
    ${sessionName}       Catenate    session_${randomNumber}
    set global variable      ${sessionName}
    create session      ${sessionName}       ${Base_Url}          timeout=30    max_retries=2      disable_warnings=1
    [Return]      ${sessionName}


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

#Post Request using data Driven Structure
#    [Documentation]    Post request with DataDriven structure
#    [Arguments]     ${sessionName}     ${URI}     ${data}    ${statuscode}
#    ${headers}=  Create Dictionary   Content-Type=application/json
#    ${resp}       post request       ${sessionName}          ${URI}      ${data}     headers=${headers}     timeout=10
#    status should be                 ${statuscode}           ${resp}
#    ${actualResult}          to json        ${resp.content}
#    set test variable       ${actualResult}
#
