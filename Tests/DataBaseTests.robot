*** Settings ***
Documentation   DataBase_Testing
Library         OperatingSystem
Library         DatabaseLibrary
Variables     ${EXEC_DIR}/Resources/Project_Configration/Test_Config.yaml




Test Template

*** Keywords ***

Connect_DB
   Set Log Level    NONE
   connect to database    pymssql      ${DBName}    ${DBUser}    ${DBPass}   ${DBHost}   ${DBPort}
   Set Log Level    INFO
Disconnect_DB
   disconnect from database





*** Test Cases ***
DB_Get_Claim_ID

    Connect_DB
    ${claim}    query    select * from Claim where Id=${4208}
    log                            ${claim[0][13]}
    set test variable              ${id}     ${claim[0][13]}
    Should Be Equal As Strings     ${id}   16
    Disconnect_DB


Validate insurance company creation
    Connect_DB
   ${InsuranceCompany}  query  select * from InsuranceCompany  where NameEn = 'Ahmed Gebril'
    log                            ${InsuranceCompany[0][3]}
    set test variable              ${IC_Phone}     ${InsuranceCompany[0][3]}
    Should Be Equal As Strings     ${InsuranceCompany[0][3]}       0178888888
    Disconnect_DB