*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
Resource          ..${/}utility${/}utility_keywords.robot
Variables         ..${/}elements${/}migo_account_page.yaml
Variables         ..${/}elements${/}migo_auth_page.yaml

*** Keywords ***
Click Account Main Tab

    Log to console  Swtich to Account Main Tab 
    Wait Element And Click Element  ${account_main_tab['${mobile}']}

Check Account Main Tab After Login

    Log to console  Account item Checking...
    Verify Element Display  ${account_profile_avatar['${mobile}']}
    Verify Element Display  ${account_profile_welcome['${mobile}']}
    Verify Element Display  ${account_profile_uid['${mobile}']}
    Verify Element Display  ${account_profile_more['${mobile}']}

    Verify Element Display  ${account_rewards_gift['${mobile}']}
    Verify Element Display  ${account_rewards_reward['${mobile}']}
    # Verify Element Display  ${account_rewards_giftcount['${mobile}']}
    Verify Element Display  ${account_rewards_migo_point['${mobile}']}
    Verify Element Display  ${account_rewards_description['${mobile}']}

    Verify Element Display  ${account_tutorial_icon['${mobile}']}
    Verify Element Display  ${account_tutorial['${mobile}']}
    Verify Element Display  ${account_tutorial_more['${mobile}']}

    Verify Element Display  ${account_tutorial_icon['${mobile}']}
    Verify Element Display  ${account_tutorial['${mobile}']}
    Verify Element Display  ${account_tutorial_more['${mobile}']}

    Verify Element Display  ${account_setting_icon['${mobile}']}
    Verify Element Display  ${account_setting['${mobile}']}
    Verify Element Display  ${account_setting_more['${mobile}']}

    Verify Element Display  ${account_tutorial_icon['${mobile}']}
    Verify Element Display  ${account_tutorial['${mobile}']}
    Verify Element Display  ${account_tutorial_more['${mobile}']}

    Verify Element Display  ${account_tutorial_icon['${mobile}']}
    Verify Element Display  ${account_tutorial['${mobile}']}
    Verify Element Display  ${account_tutorial_more['${mobile}']}

    Verify Element Display  ${account_help_icon['${mobile}']}
    Verify Element Display  ${account_help['${mobile}']}
    Verify Element Display  ${account_help_more['${mobile}']}

    Verify Element Display  ${account_wishlist_icon['${mobile}']}
    Verify Element Display  ${account_wishlist['${mobile}']}
    Verify Element Display  ${account_wishlist_more['${mobile}']}

    Verify Element Display  ${account_feedback_icon['${mobile}']}
    Verify Element Display  ${account_feedback['${mobile}']}
    Verify Element Display  ${account_feedback_more['${mobile}']}

    Verify Element Display  ${account_follow_icon['${mobile}']}
    Verify Element Display  ${account_follow['${mobile}']}
    Verify Element Display  ${account_follow_more['${mobile}']}

    Verify Element Display  ${account_logout['${mobile}']}
    Verify Element Display  ${account_version['${mobile}']}


Login Migo Account
    [Arguments]     ${contry_code}   ${phone_number} 
    [Documentation]
    ...
    ...    Login With Country Code and Phone Number
    ...  

    Click Account Main Tab
    Wait Element And Click Element   ${account_profile_avatar['${mobile}']}

    Verify Element Display  ${auth_register_title['${mobile}']}
    Verify Element Display  ${auth_register_countrycode['${mobile}']}
    Verify Element Display  ${auth_register_helphint['${mobile}']}

    Input Pohone Number      ${phone_number} 


Input Pohone Number
    [Arguments]     ${phone_number}    
    [Documentation]
    ...
    ...    Account/Phone Number Identity
    ...  

    @{number}    Split String To Characters    ${phone_number}
    FOR    ${i}    IN    @{number}
        Press Mobile Keypad    ${i}
    END

    Wait Element And Click Element   ${auth_register_agree_btn['${mobile}']}

    # : FOR    ${count}    IN RANGE    0    9
	# \   ${planNo}=      convert to string  ${count}
	# \   ${locator_EachPolicy}=     replace string  ${myPet}[labPolicyStatusOrder]    $n    ${planNo}
    # \   Run keyword if  '${planNo}'=='1'     Verify Text Label  ${locator_EachPolicy}  &{common}[policy_status_waiting_period]
    #     ...   ELSE IF   '${planNo}'=='2'     Verify Text Label  ${locator_EachPolicy}  &{common}[policy_status_effective]
    #     ...   ELSE IF   '${planNo}'=='3'     Verify Text Label  ${locator_EachPolicy}  &{common}[policy_status_canceled]
    #     ...   ELSE      Verify Text Label  ${locator_EachPolicy}    &{common}[policy_status_expired]

    Run Keyword If    '${phone_number}' == '99999999997'    Bypass Hard Code OTP Page    3   9   5   7   4   9
    Run Keyword If    '${phone_number}' == '99999999998'    Bypass Hard Code OTP Page    3   9   5   7   4   9
    Run Keyword If    '${phone_number}' == '99999999999'    Bypass Hard Code OTP Page    3   9   5   7   4   9
    #TBD
    #ELSE      Bypass OTP Page   ${phone_number} 


Press Mobile Keypad 
    [Arguments]     ${number}   

    #Ref : https://developer.android.com/reference/android/view/KeyEvent.html#KEYCODE_0
    Run Keyword If    '${number}' == '0'    Press Keycode             7
    Run Keyword If    '${number}' == '1'    Press Keycode             8
    Run Keyword If    '${number}' == '2'    Press Keycode             9
    Run Keyword If    '${number}' == '3'    Press Keycode             10
    Run Keyword If    '${number}' == '4'    Press Keycode             11
    Run Keyword If    '${number}' == '5'    Press Keycode             12
    Run Keyword If    '${number}' == '6'    Press Keycode             13
    Run Keyword If    '${number}' == '7'    Press Keycode             14
    Run Keyword If    '${number}' == '8'    Press Keycode             15
    Run Keyword If    '${number}' == '9'    Press Keycode             16
    #ELSE      Log to Console    Keycode undefined!!!


Bypass Hard Code OTP Page
    [Arguments]     ${otp_num1}   ${otp_num2}   ${otp_num3}   ${otp_num4}   ${otp_num5}   ${otp_num6}    
    [Documentation]
    ...
    ...    OTP Page
    ...  

    #OTP Page
    Log to console  OTP Number Input
    Verify Element Display  ${auth_otp_title['${mobile}']}
    Verify Element Display  ${auth_otp_desc['${mobile}']}
    Verify Element Display  ${auth_register_resend_btn['${mobile}']}
        
    Wait Element And Click Element   ${auth_register_resend_hint['${mobile}']}
    Verify Element Display  ${auth_register_dialog['${mobile}']}
    Verify Element Display  ${auth_register_description['${mobile}']}
    Wait Element And Click Element   ${auth_register_dialog_ok['${mobile}']}
    
    #OTP field
    Wait Element And Input    ${auth_register_otp_1['${mobile}']}    ${otp_num1}
    Wait Element And Input    ${auth_register_otp_2['${mobile}']}    ${otp_num2}
    Wait Element And Input    ${auth_register_otp_3['${mobile}']}    ${otp_num3}
    Wait Element And Input    ${auth_register_otp_4['${mobile}']}    ${otp_num4}
    Wait Element And Input    ${auth_register_otp_5['${mobile}']}    ${otp_num5}
    Wait Element And Input    ${auth_register_otp_6['${mobile}']}    ${otp_num6}

#Not Done Yet
Bypass OTP Page   
    [Arguments]     ${phone_number} 
    [Documentation]
    ...
    ...    OTP Page
    ...  

    #OTP Page
    Log to console  OTP Number Input
    Verify Element Display  ${auth_otp_title['${mobile}']}
    Verify Element Display  ${auth_otp_desc['${mobile}']}
    Verify Element Display  ${auth_register_resend_btn['${mobile}']}
        
    Wait Element And Click Element   ${auth_register_resend_hint['${mobile}']}
    Verify Element Display  ${auth_register_dialog['${mobile}']}
    Verify Element Display  ${auth_register_description['${mobile}']}
    Wait Element And Click Element   ${auth_register_dialog_ok['${mobile}']}
    
    #Need to Integrate with OTP API

    #OTP field
    Wait Element And Input    ${auth_register_otp_1['${mobile}']}    ${otp_num1}
    Wait Element And Input    ${auth_register_otp_2['${mobile}']}    ${otp_num2}
    Wait Element And Input    ${auth_register_otp_3['${mobile}']}    ${otp_num3}
    Wait Element And Input    ${auth_register_otp_4['${mobile}']}    ${otp_num4}
    Wait Element And Input    ${auth_register_otp_5['${mobile}']}    ${otp_num5}
    Wait Element And Input    ${auth_register_otp_6['${mobile}']}    ${otp_num6}

#Not Done Yet
Check Hello Profile Page   
    [Documentation]
    ...
    ...    Hello profile page (The first time)
    ...  

    #Hello profile page
    Verify Element Display  ${auth_Hello_info_title['${mobile}']}
    Verify Element Display  ${auth_Hello_info_subtitle['${mobile}']}
    Verify Element Display  ${auth_Hello_info_name['${mobile}']}
    Verify Element Display  ${auth_Hello_info_gender['${mobile}']}
    Verify Element Display  ${auth_Hello_info_birday['${mobile}']}
    Verify Element Display  ${auth_Hello_info_ig['${mobile}']}
    Verify Element Display  ${auth_Hello_info_refferl['${mobile}']}
    Wait Element And Click Element   ${auth_Hello_info_next_btn['${mobile}']}
    Verify Element Display  ${auth_login_success_toast['${mobile}']}

Logout
    [Documentation]
    ...
    ...    Logout Migo Account and Check some item should not be seen
    ...  

    Click Account Main Tab

    #Logout
    Wait Element And Click Element  ${account_main_tab['${mobile}']}
    Wait Element And Click Element  ${account_logout['${mobile}']}
    Wait Element And Click Element      ${account_logout_confrim_btn['${mobile}']}

    #Should Not Display Payment method and Parental Control
    Verify Element Not Display  ${account_payment['${mobile}']}
    Verify Element Not Display  ${account_parental['${mobile}']}

Check User Profile Information Storage   
    [Arguments]     ${fullname}=${my_fullname}    ${gender}=${my_gender}    ${birthdaty}=${my_birthdaty}     ${ig}=${my_ig}  
    [Documentation]
    ...
    ...    Check Account Data sync
    ...     

    #Check account setting
    Log to console  Verify Account profile and setting.....
    Wait Element And Click Element  ${account_profile_more['${mobile}']}
    Wait Element And Click Element  ${account_setting_profileinfo['${mobile}']}
    Get Text And Compare    ${account_profile_info_fullname['${mobile}']}   ${fullname}
    Get Text And Compare    ${account_profile_info_gender['${mobile}']}     ${gender}
    Get Text And Compare    ${account_profile_info_birthday['${mobile}']}   ${birthdaty}
    Get Text And Compare    ${account_profile_info_ig['${mobile}']}     ${ig}

Change User Profile Information Referral Code   

    #Account and setting
    Log to console  Verify Account profile and setting.....
    Wait Element And Click Element  ${account_profile_more['${mobile}']}
    Wait Element And Click Element  ${account_setting_account['${mobile}']}
    Verify Element Display  ${account_profile_info_title['${mobile}']}
    Verify Element Display  ${account_profile_info['${mobile}']}
    Verify Element Display  ${account_profile_verified['${mobile}']}
    Verify Element Display  ${account_profile_icon['${mobile}']}
    Wait Element And Click Element  ${account_profile_info_back['${mobile}']}

    Wait Element And Click Element  ${account_setting_profileinfo['${mobile}']}
    Verify Element Display  ${account_profile_info_fullname['${mobile}']}
    Verify Element Display  ${account_profile_info_gender['${mobile}']}
    Verify Element Display  ${account_profile_info_birthday['${mobile}']}
    Verify Element Display  ${account_profile_info_ig['${mobile}']}

    ${referral_code}    FakerLibrary.Random Int    min=1000    max=9999
    Wait Element And Input  ${account_profile_info_referral['${mobile}']}     ${referral_code} 
    Wait Element And Click Element  ${account_profile_info_save_btn['${mobile}']}
    Verify Element Display  ${account_profile_info_save_toast['${mobile}']}
    Wait Element And Click Element  ${account_profile_info_back['${mobile}']}
    Wait Element And Click Element  ${account_profile_info_back['${mobile}']}  

Migo Point Should Not Be Zero

    Sleep  2s
    Get Text And Not Equal    ${account_rewards_giftcount['${mobile}']}    0  
    Get Text And Not Equal    ${account_rewards_migo_point['${mobile}']}    0  

Check My Migo Reward Page

    Log to console  Verify My Migo reward
    Wait Element And Click Element  ${account_rewards_reward['${mobile}']}
    Verify Element Display  ${account_rewards_point_number['${mobile}']}
    Verify Element Display  ${account_rewards_point_description['${mobile}']}
    Verify Element Display  ${account_rewards_point_level['${mobile}']}

Check Gift Redeem Flow
    [Documentation]
    ...
    ...    User case for Gift Redeem Flow(include error checking)
    ...     

    Verify Element Display  ${account_rewards_point_level['${mobile}']}
    Wait Element And Click Element  ${account_rewards_point_levels_gift1['${mobile}']}
    Verify Element Display  ${account_rewards_point_levels_claim_img['${mobile}']}
    Verify Element Display  ${account_rewards_point_levels_claim_title['${mobile}']}
    Wait Element And Click Element  ${account_rewards_point_levels_claim_btn['${mobile}']}

    Wait Element And Input  ${account_rewards_point_levels_claim_code_field['${mobile}']}     qaqaqa
    Wait Element And Click Element  ${account_rewards_point_levels_claim_code_confrim_btn['${mobile}']}
    Verify Element Display  ${account_rewards_point_levels_claim_code_error['${mobile}']}
    Wait Element And Click Element  ${account_rewards_point_levels_claim_code_cancel_btn['${mobile}']}
    Wait Element And Click Element  ${account_rewards_point_levels_claim_close['${mobile}']}

    Wait Element And Click Element  ${account_rewards_point_earn_tab['${mobile}']}
    Verify Element Display  ${account_rewards_point_earn_section['${mobile}']}
    Wait Element And Click Element  ${account_rewards_point_history_tab['${mobile}']}
    Verify Element Display  ${account_rewards_point_history_section['${mobile}']}

    Wait Element And Click Element  ${account_rewards_point_back_btn['${mobile}']}
 

Check Migo App Tutorail

    Log to console  Verify Migo App Tutorial
    Wait Element And Click Element  ${account_tutorial_more['${mobile}']}
    Wait Element And Click Element  ${account_tutorials_close['${mobile}']}

Check Help Center 

    Log to console  Help Center
    Wait Element And Click Element  ${account_help_more['${mobile}']}
    Verify Element Display  ${account_help_contact_us['${mobile}']}
    Get Text And Compare    ${account_help_whatsapp['${mobile}']}   	WhatsApp
    Get Text And Compare    ${account_help_whatsapp_content['${mobile}']}   	0811-281-MIGO (6446)
    Get Text And Compare    ${account_help_facebook['${mobile}']}   	Facebook Messenger
    Get Text And Compare    ${account_help_facebook_content['${mobile}']}   	@Migoindo
    Get Text And Compare    ${account_help_ig['${mobile}']}   	Instagram
    Get Text And Compare    ${account_help_ig_content['${mobile}']}   @migoindonesia
    Verify Element Display  ${account_help_termsofuse['${mobile}']}
    Verify Element Display  ${account_help_userid['${mobile}']}    

    Wait Element And Click Element  ${acount_help_back_btn['${mobile}']}
    

Check Payment Method

    Wait Element And Click Element  ${account_payment['${mobile}']}  
    Verify Element Display  ${passes_select_method_cash_radio_btn['${mobile}']}  
    Verify Element Display  ${passes_select_method_ovo_radio_btn['${mobile}']}  
    Verify Element Display  ${passes_select_method_dana_radio_btn['${mobile}']}  
    Verify Element Display  ${passes_select_method_shopeepay_radio_btn['${mobile}']}  
    Wait Element And Click Element  ${passes_select_method_save_btn['${mobile}']}  


Check Parental Control
    [Arguments]     ${level}   

    Wait Element And Click Element  ${account_parental['${mobile}']} 
    Verify Element Display  ${account_parental_home_parental_control['${mobile}']}  
    Get Text And Compare  ${account_parental_home_level['${mobile}']}   ${level}  

Get Daily Build Hash

    ${tv_app_version}=    Wait Element And Get Text   ${account_version['${mobile}']}
    ${regex}=    Get Regexp Matches   ${tv_app_version}     \\[.*\\]
    ${version}=    Remove String   ${regex[0]}    [   ]
    Log to console  \n${version}

    [return]    ${version}

Check Transaction History
    [Arguments]     ${pass_day}   ${payment_method}    ${trans_num}    ${pass_price}       ${status} 
    [Documentation]
    ...
    ...    Check Transaction History
    ...  

    Wait Element And Click Element  ${account_transactiont['${mobile}']} 
    ${date}=    Get Current Date    result_format==%Y-%m-%d
    ${date}=    Convert Date To ddMMyyyy   ${date}
    Get Text And Contain   ${account_transactiont_thelatest_history_time['${mobile}']}   ${date}
    Get Text And Compare   ${account_transactiont_thelatest_history_day['${mobile}']}   ${pass_day}
    Get Text And Compare   ${account_transactiont_thelatest_history_method['${mobile}']}   ${payment_method}
    Get Text And Compare   ${account_transactiont_thelatest_history_trans_num['${mobile}']}   \#${trans_num}   
    Get Text And Compare   ${account_transactiont_thelatest_history_price['${mobile}']}   ${pass_price}   
    Get Text And Compare   ${account_transactiont_thelatest_history_status['${mobile}']}   ${status} 
    Press Keycode   4

Check Parental Control Page

    Wait Element And Click Element  ${account_parental['${mobile}']}

    Verify Element Display  ${account_parental_control_title['${mobile}']}
    Verify Element Display  ${account_parental_control_subtitle['${mobile}']}
    Verify Element Display  ${account_parental_control_graph['${mobile}']}
    Verify Element Display  ${account_parental_learn_more['${mobile}']}

    Wait Element And Click Element  ${account_parental_learn_more['${mobile}']}
    Verify Element Display  ${account_parental_learn_more_dialog['${mobile}']}
    Wait Element And Click Element  ${account_parental_learn_more_dialog_btn['${mobile}']}

Set Parental Control

    Wait Element And Click Element  ${account_parental_control_bar['${mobile}']}

Set PIN Code
    [Arguments]     ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4}    
    [Documentation]
    ...
    ...    Set PIN Code
    ...  

    Verify Element Display  ${account_parental_set_pin['${mobile}']}
    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}

Confirm PIN Code with Error
    [Arguments]     ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4}    

    Verify Element Display  ${account_parental_set_pin['${mobile}']}
    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}
    Verify Element Display  ${account_parental_set_pin_error['${mobile}']}

Confirm PIN Code
    [Arguments]     ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4}    

    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}
    Wait Element And Click Element  ${account_parental_set_pin_btn['${mobile}']}

Check Default Restriction

    Get Text And Compare  ${account_parental_restriction_display['${mobile}']}    D21+


Set Content Restriction
    [Arguments]     ${restriction}     

    Run Keyword If  '${restriction}' == 'D17+'
    ...   Run Keywords
    ...   Wait Element And Click Element    ${account_parental_restriction_17_btn['${mobile}']}    
    ...   AND  
    ...   Get Text And Compare  ${account_parental_restriction_display['${mobile}']}    ${restriction}

    Run Keyword If  '${restriction}' == 'R13+'
    ...   Run Keywords
    ...   Wait Element And Click Element    ${account_parental_restriction_13_btn['${mobile}']}    
    ...   AND  
    ...   Get Text And Compare  ${account_parental_restriction_display['${mobile}']}    ${restriction}

    Wait Element And Click Element  ${account_parental_restriction_save_btn['${mobile}']}

    Get Text And Compare  ${account_parental_home_level['${mobile}']}    ${restriction} 


Change Restriction
    [Arguments]     ${restriction}   ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4}    

    Wait Element And Click Element  ${account_parental_home_change_restriction['${mobile}']}  

    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}

    Set Content Restriction   ${restriction}
 
Reset PIN Code
    [Arguments]     ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4} 
    
    #New Pin code
    Wait Element And Click Element  ${account_parental_home_tv_reset_pin['${mobile}']}
    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}



Play and Check Video With PIN Code  
    [Arguments]     ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4} 

    Wait Element And Click Element  ${downloads_play_video_icon['${mobile}']}

    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}
    Sleep  2s


Close Parental Control 
    [Arguments]     ${pin_code1}   ${pin_code2}    ${pin_code3}    ${pin_code4} 

    Wait Element And Click Element  ${account_parental['${mobile}']}
    Wait Element And Click Element  ${account_parental_home_parental_control['${mobile}']}

    Wait Element And Input    ${account_parental_set_pin_field1['${mobile}']}    ${pin_code1}
    Wait Element And Input    ${account_parental_set_pin_field2['${mobile}']}    ${pin_code2}
    Wait Element And Input    ${account_parental_set_pin_field3['${mobile}']}    ${pin_code3}
    Wait Element And Input    ${account_parental_set_pin_field4['${mobile}']}    ${pin_code4}
    Verify Element Display  ${account_parental_control_graph['${mobile}']}



