*** Settings ***
Documentation	Migo buy pass web page
Library          SeleniumLibrary    run_on_failure=SeleniumLibrary.CapturePageScreenshot
Library          BuiltIn
Library          DateTime
Library          String
Library          Collections
Library 	     OperatingSystem
Library 	     Dialogs
Library          JSONLibrary
Library          RequestsLibrary
Resource         ..${/}variables.resource
Resource         ..${/}elements${/}migo_web_page.robot

*** Variables ***
${browser}    chrome
${sell_pass_account}  test1
${sell_pass_password}  migotest
${mitra_migo_sell_pass_prd}  https://mitra.migo.io/login

*** Keywords ***
#Note PRD for now
Confirm Cash Transaction of Buy Migo Passes
    [Teardown]    Close Buy Pass Browser

    [Arguments]
    ...    ${text_code}

    Open Page   ${mitra_migo_sell_pass_prd}    ${browser}
    log to console  ${sellpass['fieldRetailerID']}
    Input Data   ${sellpass['fieldRetailerID']}      ${sell_pass_account}
    Input Data   ${sellpass['fieldPassword']}      ${sell_pass_password}
    Submit Button   ${sellpass['btnLogin']}  

    Sleep  1s
    Submit Button   ${sellpass['btnTextCode']}  
    Input Data   ${sellpass['fieldCode']}      ${text_code}
    Sleep  1s
    Submit Button   ${sellpass['btnSubmit']} 
    Submit Button   ${sellpass['btnConfirmTransaction']} 
    Submit Button   ${sellpass['btnBacktoHome']} 

         
Close Buy Pass Browser
    [Documentation]    Close browser always after finish run
    Log To Console    ${\n}Close Browser
    Close Browser
    