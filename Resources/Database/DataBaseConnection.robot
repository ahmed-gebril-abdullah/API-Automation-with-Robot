*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Variables     ${EXEC_DIR}/Resources/Project_Configration/Test_Config.yaml

*** Keywords ***

Connect_DB
   Set Log Level    NONE
   connect to database    pymssql      ${DBName}    ${DBUser}    ${DBPass}   ${DBHost}   ${DBPort}
   Set Log Level    INFO
Disconnect_DB
   disconnect from database


*** Test Cases ***
#test1
#  Connect_DB
#      ${claim}    query    select * from Claim where Id=1
#    log    ${claim[0][13]}
#    #log    ${claim[0][1]}
#    set test variable    ${id}     ${claim[0][13]}
#    Should Be Equal As Strings        ${id}   11
#
#  Disconnect_DB
