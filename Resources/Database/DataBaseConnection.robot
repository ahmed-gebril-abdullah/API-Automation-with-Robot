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


