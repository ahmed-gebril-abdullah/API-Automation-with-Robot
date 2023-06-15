*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library          DateTime
Resource    ../Database/DataBaseConnection.robot

*** Keywords ***
DB_Get_PolicyHolder_details_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Identity_num}    query    SELECT PH.* FROM [dbo].[PolicyHolder] PH LEFT JOIN [dbo].[Application] ON ApplicationId = Id WHERE Reference= '${Application_ref}'
    set test variable    ${DB_Identity_number}     ${Identity_num[0][1]}
    ${Sponser_NUM}    query    SELECT PH.* FROM [dbo].[PolicyHolder] PH LEFT JOIN [dbo].[Application] ON ApplicationId = Id WHERE Reference= '${Application_ref}'
    set test variable    ${SponserNumber}     ${Sponser_NUM[0][2]}
    Disconnect_DB

DB_Get_PolicyHolder_details_By_Identity_num
    [Arguments]    ${Identity_num}
    connect_db
    ${ApplicationREF}    query    SELECT App.* FROM Application As App LEFT JOIN PolicyHolder ON ApplicationId = App.Id WHERE IdentityNumber ='${Identity_num}' and PaymentGeneratedOn is null and CreationDate >= DATEadd(HOUR,-9.9,GETDATE()) order by 1 desc

    set test variable    ${DB_Application_ref}     ${ApplicationREF[0][17]}
    Disconnect_DB

DB_Get_QuoteREF_details_By_Identity_num
    [Arguments]    ${Identity_num}
    connect_db
    ${QuoteREF}    query    select Quote.* FROM Quotation As Quote LEFT JOIN PolicyHolder As PH ON Quote.ApplicationId = PH.ApplicationId WHERE IdentityNumber ='${Identity_num}' order by 1 desc
    set test variable    ${QUOTEref}     ${QuoteREF[0][6]}
    Disconnect_DB

#DB_Get_Application_details_By_ApplicationID
#    [Arguments]    ${Application_ID}
#    connect_db
#    ${App_ref}    query    SELECT * FROM Application WHERE Id='${Application_ID}' order by 1 desc
#    set test variable    ${DB_application_Ref}     ${App_ref[0][17]}
#    Disconnect_DB


DB_Get_EffectiveDate_from_Application_table_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Effective_Date}    query    SELECT id , EffectiveDate, Reference from [dbo].[Application] where Reference='${Application_ref}'
    log    ${Effective_Date[0][1]}
    ${date} 	Convert Date	${Effective_Date[0][1]}	 result_format=%d-%m-%Y
    set test variable     ${DB_EffectiveDate}     ${date}
    Disconnect_DB



DB_Get_QuestionsAnswer_from_Declaration_table_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
    set test variable    ${DB_QuestionsAnswers_1}    ${Questions_Answers[0][2]}
    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
    set test variable    ${DB_QuestionsAnswers_2}    ${Questions_Answers[1][2]}
     ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
    set test variable    ${DB_QuestionsAnswers_3}    ${Questions_Answers[2][2]}
     ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
    set test variable    ${DB_QuestionsAnswers_4}    ${Questions_Answers[3][2]}
     ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
    set test variable    ${DB_QuestionsAnswers_5}    ${Questions_Answers[4][2]}
    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
    set test variable    ${DB_QuestionsAnswers_6}    ${Questions_Answers[5][2]}
    Disconnect_DB



DB_Get_QouteReferenceCount_from_Qoutation_table_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Qoute_ReferenceCount}    query    SELECT COUNT (*) NumOfRows FROM [dbo].[Quotation] Qoutation LEFT JOIN [dbo].[Application] ON ApplicationId = [dbo].[Application].Id WHERE [dbo].[Application].Reference ='${Application_ref}'
    log    ${Qoute_ReferenceCount[0][0]}
    set test variable    ${DB_QouteReferenceCount}    ${Qoute_ReferenceCount[0][0]}
    Disconnect_DB


DB_Get_QuoteID_from_Quotation_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Quote_ID_quotation}    query    SELECT * FROM Quotation LEFT JOIN Application ON ApplicationId = Application.Id WHERE Application.Reference ='${Application_ref}' order by 1 asc
    set test variable    ${DB_QuoteIDquotation}    ${Quote_ID_quotation[0][0]}
    Disconnect_DB

DB_Get_QuoteID_from_application_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Quote_ID_application}    query     SELECT * FROM Application LEFT JOIN Quotation ON Application.Id = ApplicationId WHERE Application.Reference ='${Application_ref}' order by 1 desc

    set test variable    ${DB_QuoteIDapplication}    ${Quote_ID_application[0][11]}
    Disconnect_DB

DB_Get_ApplicationID_from_Invoice_table_By_ApplicationRef
    [Arguments]    ${Application_ref}
    connect_db
    ${Application_ID}    query    SELECT Invoice.* FROM [dbo].[Invoice] Invoice LEFT JOIN [dbo].[Application] ON ApplicationId = [dbo].[Application].Id WHERE [dbo].[Application].Reference ='${Application_ref}'
    log    ${Application_ID[0][0]}
    set test variable    ${DB_ApplicationID}    ${Application_ID[0][0]}
    Disconnect_DB





##DB_Get_QuestionsAnswer_2_from_Declaration_table_By_ApplicationRef
##    [Arguments]    ${Application_ref}
##    connect_db
##    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
##    log    ${Questions_Answers[1][2]}
##    set test variable    ${DB_QuestionsAnswers_2}    ${Questions_Answers[1][2]}
##    Disconnect_DB
#
#
#DB_Get_QuestionsAnswer_3_from_Declaration_table_By_ApplicationRef
#    [Arguments]    ${Application_ref}
#    connect_db
#    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
#    log    ${Questions_Answers[2][2]}
#    set test variable    ${DB_QuestionsAnswers_3}    ${Questions_Answers[2][2]}
#    Disconnect_DB
#
#
#DB_Get_QuestionsAnswer_4_from_Declaration_table_By_ApplicationRef
#    [Arguments]    ${Application_ref}
#    connect_db
#    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
#    log    ${Questions_Answers[3][2]}
#    set test variable    ${DB_QuestionsAnswers_4}    ${Questions_Answers[3][2]}
#    Disconnect_DB
#
#
#DB_Get_QuestionsAnswer_5_from_Declaration_table_By_ApplicationRef
#    [Arguments]    ${Application_ref}
#    connect_db
#    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
#    log    ${Questions_Answers[4][2]}
#    set test variable    ${DB_QuestionsAnswers_5}    ${Questions_Answers[4][2]}
#    Disconnect_DB
#
#DB_Get_QuestionsAnswer_6_from_Declaration_table_By_ApplicationRef
#    [Arguments]    ${Application_ref}
#    connect_db
#    ${Questions_Answers}    query    SELECT Declaration.* FROM [dbo].[Declaration] Declaration LEFT JOIN [dbo].[Application] ON PolicyHolderId = Id WHERE Reference='${Application_ref}'
#    log    ${Questions_Answers[5][2]}
#    set test variable    ${DB_QuestionsAnswers_6}    ${Questions_Answers[5][2]}
#    Disconnect_DB
