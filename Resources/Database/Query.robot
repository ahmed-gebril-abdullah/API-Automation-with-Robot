*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Resource    ../Database/DataBaseConnection.robot

*** Keywords ***
Test_Claim

    connect_db
    ${claim}    query    select * from Claim
    log    ${claim[0][13]}
    #log    ${claim[0][1]}
    set test variable    ${id}     ${claim[0][13]}
    Disconnect_DB

*** Test Cases ***

test1
  Test_Claim