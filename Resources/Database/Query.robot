*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Resource    ../Database/DataBaseConnection.robot

*** Keywords ***
Get_CoverPlan_ref_By_QouteRef
    [Arguments]    ${Qoute_ref}
    connect_db
    ${CoverPlan_ref}    query    Select top 1 Reference from CoverPlan where DurationId in (select top 1 id from Duration where QuotationId in (select id from Quotation where Reference='${Qoute_ref}'))
    log    ${CoverPlan_ref[0][0]}
    set test variable    ${coverplan}     ${CoverPlan_ref[0][0]}
    Disconnect_DB

