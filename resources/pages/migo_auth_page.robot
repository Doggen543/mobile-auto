*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
Resource          ..${/}utility${/}utility_keywords.robot
Resource          ..${/}pages${/}migo_account_page.robot
Variables         ..${/}elements${/}migo_auth_page.yaml

*** Keywords ***
Eliminate Test Account

    [Arguments]     ${contry_code}   ${phone_number}   
    [Documentation]
    ...
    ...    curl API to delete account
    ...     

    Run Process     curl -u account:accountr00t https://api-account.migosrv.com/api/admin/accounts -XDELETE --data '{ "country_code": "${contry_code}", "phone_number": "${phone_number}" }'      shell=True 
    Sleep  1s

Allow Device Permission
 
    [Documentation]
    ...
    ...    Allowing Device Permission
    ...     

    #Allowing device permission
    Wait Element And Click Element      ${auth_permisson_next_btn['${mobile}']}
    Wait Element And Click Element      ${auth_permisson_storage_allow_btn['${mobile}']}
    Wait Element And Click Element      ${auth_permisson_next_btn['${mobile}']}
    Wait Element And Click Element      ${auth_permisson_location_allow_btn['${mobile}']}

Browse Catalog First
 
    [Documentation]
    ...
    ...    Next the tutorail and Browse Catalog First
    ...     

    Wait Element And Click Element      ${auth_register_login_next_btn['${mobile}']}
    Wait Element And Click Element      ${auth_register_login_next_btn['${mobile}']}
    Wait Element And Click Element      ${auth_browse_first_btn['${mobile}']}
    Sleep  2s

Register or Login First
    
    [Arguments]     ${contry_code}   ${phone_number}   
    [Documentation]
    ...
    ...    Login
    ...     

    Wait Element And Click Element      ${auth_register_login_next_btn['${mobile}']}
    Wait Element And Click Element      ${auth_register_login_next_btn['${mobile}']}
    Wait Element And Click Element      ${auth_register_login_btn['${mobile}']}
    Sleep  2s
    Verify Element Display  ${auth_register_title['${mobile}']}
    Verify Element Display  ${auth_register_countrycode['${mobile}']}
    Verify Element Display  ${auth_register_helphint['${mobile}']}

    Input Pohone Number      ${phone_number} 


Change debug Recording Prevention

    Wait Element And Click Element  ${catalog_main_debug_info['${mobile}']}  
    Scroll To Element And Click     ${catalog_main_debug_recording_prevention['${mobile}']} 
    Wait Element And Click Element  ${catalog_main_debug_back_btn['${mobile}']}   
    

Change Wifi From Public To MDS
 
    [Documentation]
    ...
    ...    Public to MDS
    ...     

    Get Text And Compare    ${downloads_state['${mobile}']}   Migo WiFi Disconnected
    Wait Element And Click Element  ${downloads_state['${mobile}']}

    Verify Element Display  ${downloads_wifi_dialog_title['${mobile}']}
    Verify Element Display  ${downloads_wifi_dialog_img['${mobile}']}
    Wait Element And Click Element  ${downloads_wifi_dialog_setting_btn['${mobile}']}

    Wait Element And Click Element  ${downloads_wifi_mds['${mobile}']}
    Press Keycode   4
    Sleep  3s

User Press Back Key

    Sleep  1s
    Press Keycode   4
    Sleep  1s
