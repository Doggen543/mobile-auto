*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
Resource          ..${/}utility${/}utility_keywords.robot
Variables         ..${/}elements${/}migo_passes_page.yaml
Variables         ..${/}elements${/}migo_auth_page.yaml

*** Keywords ***
Click Passes Main Tab

    Log to console  Swtich to Passes Main Tab 
    Wait Element And Click Element  ${passes_main_tab['${mobile}']}

Check the Onboard Passes Tutorials

    [Documentation]
    ...
    ...    Click Passes tab to Check Passes tutorials 
    ...   

    Click Passes Main Tab
    Verify Element Display  ${passes_onboard_tutorials_skip['${mobile}']}
    Verify Element Display  ${passes_onboard_tutorials_img['${mobile}']}
    Verify Element Display  ${passes_onboard_tutorials_title['${mobile}']}
    Verify Element Display  ${passes_onboard_tutorials_subtitle['${mobile}']}
    Wait Element And Click Element   ${passes_onboard_tutorials_btn['${mobile}']}
    Wait Element And Click Element   ${passes_onboard_tutorials_btn['${mobile}']}
    Wait Element And Click Element   ${passes_onboard_tutorials_btn['${mobile}']}
    Wait Element And Click Element   ${passes_onboard_tutorials_btn['${mobile}']}
    Verify Element Display  ${passes_migo_passes_status['${mobile}']}

Check Passes Price

    [Documentation]
    ...
    ...    Check Passes Price hard code  
    ...   
    Log to Console  Checking the whole day passes and price
    #1 day
    Get Text And Compare    ${passes_migo_passes_1_day['${mobile}']}   Paket 1 Hari   
    Get Text And Compare    ${passes_migo_passes_1_day_price['${mobile}']}   Rp 3.000
    Verify Element Not Display  ${passes_migo_passes_1_day_promo_price['${mobile}']}
    Verify Element Display  ${passes_migo_passes_1_day_buy_btn['${mobile}']}
    #3 day
    Get Text And Compare    ${passes_migo_passes_3_day['${mobile}']}   Paket 3 Hari      
    Get Text And Compare    ${passes_migo_passes_3_day_price['${mobile}']}   Rp 5.000
    Get Text And Compare    ${passes_migo_passes_3_day_promo_price['${mobile}']}   Rp 7.000 
    Verify Element Display  ${passes_migo_passes_3_day_buy_btn['${mobile}']}
    #7 day
    Get Text And Compare    ${passes_migo_passes_7_day['${mobile}']}   Paket 7 Hari      
    Get Text And Compare    ${passes_migo_passes_7_day_price['${mobile}']}   Rp 10.000
    Get Text And Compare    ${passes_migo_passes_7_day_promo_price['${mobile}']}   Rp 15.000 
    Verify Element Display  ${passes_migo_passes_7_day_buy_btn['${mobile}']}
    #30 day
    Get Text And Compare    ${passes_migo_passes_30_day['${mobile}']}   Paket 30 Hari      
    Get Text And Compare    ${passes_migo_passes_30_day_price['${mobile}']}   Rp 30.000
    Get Text And Compare    ${passes_migo_passes_30_day_promo_price['${mobile}']}   Rp 39.000 
    Verify Element Display  ${passes_migo_passes_30_day_buy_btn['${mobile}']}

Check My passes Empty

    #Check My passes
    Wait Element And Click Element  ${passes_my_passes_tab['${mobile}']}
    Get Text And Compare    ${passes_migo_passes_status['${mobile}']}   Buy Migo Pass
    Verify Element Display  ${passes_my_passes_no_passes['${mobile}']}


Redeem Promocode    
    [Arguments]     ${Promo_code} 
    
    #Promo code
    Wait Element And Click Element  ${passes_promo_code_tab['${mobile}']}
    Wait Element And Input    ${passes_promo_code_field['${mobile}']}   qaqa
    Wait Element And Click Element  ${passes_promo_code_redeem_btn['${mobile}']}
    Verify Element Display  ${passes_promo_code_redeem_error['${mobile}']}

    Wait Element And Input    ${passes_promo_code_field['${mobile}']}   ${Promo_code} 
    Wait Element And Click Element  ${passes_promo_code_redeem_btn['${mobile}']}

    Verify Element Display  ${passes_promo_code_redeem_result_dialog['${mobile}']}
    Get Text And Compare    ${passes_promo_code_redeem_result_dialog_title['${mobile}']}   Redeem Success
    Wait Element And Click Element  ${passes_promo_code_redeem_result_dialog_title_btn['${mobile}']}
    Get Text And Compare    ${passes_migo_passes_status['${mobile}']}   Activate Your Pass

Activate Pass
    [Arguments]     ${status}

    Wait Element And Click Element  ${passes_my_passes_active_pass_btn['${mobile}']}
    Verify Element Display  ${passes_my_passes_active_pass_dialog['${mobile}']}
    Wait Element And Click Element  ${passes_my_passes_active_pass_dialog_active_btn['${mobile}']}
    Get Text And Compare    ${passes_migo_passes_status['${mobile}']}   ${status}

Check MDS Far Dialog

    Wait Element And Click Element  ${passes_migo_passes_1_day_buy_btn['${mobile}']}
    Verify Element Display  ${passes_mds_far_dialog['${mobile}']}
    Verify Element Display  ${passes_mds_far_dialog_title['${mobile}']}
    Verify Element Display  ${passes_mds_far_dialog_find['${mobile}']}
    Verify Element Display  ${passes_mds_far_dialog_continue['${mobile}']}
    Wait Element And Click Element  ${passes_mds_far_dialog_find['${mobile}']}
    Verify Element Display  ${location_location_btn['${mobile}']}

Check Buy Migo Pass Dialog
    [Arguments]     ${day}    ${price}    ${payment_method}

    Run Keyword If    '${day}' == 'Paket 1 Hari'     Wait Element And Click Element  ${passes_migo_passes_1_day_buy_btn['${mobile}']}
    Run Keyword If    '${day}' == 'Paket 3 Hari'    Wait Element And Click Element  ${passes_migo_passes_3_day_buy_btn['${mobile}']}
    Run Keyword If    '${day}' == 'Paket 7 Hari'    Wait Element And Click Element  ${passes_migo_passes_7_day_buy_btn['${mobile}']}
    Run Keyword If    '${day}' == 'Paket 30 Hari'    Wait Element And Click Element  ${passes_migo_passes_30_day_buy_btn['${mobile}']}

    Wait Element And Click Element  ${passes_mds_far_dialog_continue['${mobile}']}
    Verify Element Display  ${passes_buypass_title['${mobile}']}
    Verify Element Display  ${passes_buypass_close['${mobile}']}
    Get Text And Compare    ${passes_buypass_type['${mobile}']}   ${day}  
    Get Text And Compare    ${passes_buypass_method_title['${mobile}']}   Payment Methods

    Log to console  ${payment_method}
    Run Keyword If    '${payment_method}' == 'Cash'    Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay at Warung Migo
    Run Keyword If    '${payment_method}' == 'OVO'    Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay with E-wallet
    Run Keyword If    '${payment_method}' == 'DANA'    Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay with E-wallet
    Run Keyword If    '${payment_method}' == 'ShopeePay'   Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay with E-wallet

    Get Text And Compare    ${passes_buypass_method_name['${mobile}']}   ${payment_method}
    Verify Element Display    ${passes_buypass_method_icon['${mobile}']}   

Check Payment Method Options

    Log to Console  Check Payment Method
    #Change to e-wallet
    Wait Element And Click Element  ${passes_buypass_method['${mobile}']}
    Verify Element Display  ${passes_select_paymentmethod['${mobile}']}
    Verify Element Display  ${passes_select_paymentmethod_close['${mobile}']}
    Verify Element Display  ${passes_select_method['${mobile}']}
    #Cash
    Get Text And Compare    ${passes_select_method_cash_desc['${mobile}']}   	Pay at Warung Migo
    Get Text And Compare    ${passes_select_method_cash_name['${mobile}']}   Cash
    Verify Element Display    ${passes_select_method_cash_icon['${mobile}']}
    #OVO
    Get Text And Compare    ${passes_select_method_ovo_desc['${mobile}']}   	Pay with E-wallet
    Get Text And Compare    ${passes_select_method_ovo_name['${mobile}']}   OVO
    Verify Element Display    ${passes_select_method_ovo_icon['${mobile}']}
    #DANA
    Get Text And Compare    ${passes_select_method_dana_desc['${mobile}']}   	Pay with E-wallet
    Get Text And Compare    ${passes_select_method_dana_name['${mobile}']}   DANA
    Verify Element Display    ${passes_select_method_dana_icon['${mobile}']}
    #ShopeePay
    Get Text And Compare    ${passes_select_method_shopeepay_desc['${mobile}']}   	Pay with E-wallet
    Get Text And Compare    ${passes_select_method_shopeepay_name['${mobile}']}   ShopeePay
    Verify Element Display    ${passes_select_method_shopeepay_icon['${mobile}']}

Select Payment Method 
    [Arguments]     ${payment_method}

    Run Keyword If    '${payment_method}' == 'Cash'     Wait Element And Click Element  ${passes_select_method_cash_radio_btn['${mobile}']}
    Run Keyword If    '${payment_method}' == 'OVO'     Wait Element And Click Element  ${passes_select_method_ovo_radio_btn['${mobile}']}
    Run Keyword If    '${payment_method}' == 'DANA'    Wait Element And Click Element  ${passes_select_method_dana_radio_btn['${mobile}']}
    Run Keyword If    '${payment_method}' == 'ShopeePay'    Wait Element And Click Element  ${passes_select_method_shopeepay_radio_btn['${mobile}']}

    Wait Element And Click Element  ${passes_select_method_save_btn['${mobile}']}
    Get Text And Compare    ${passes_buypass_method_title['${mobile}']}   Payment Methods

    Log to console  ${payment_method}
    Run Keyword If    '${payment_method}' == 'Cash'    Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay at Warung Migo
    Run Keyword If    '${payment_method}' == 'OVO'    Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay with E-wallet
    Run Keyword If    '${payment_method}' == 'DANA'    Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay with E-wallet
    Run Keyword If    '${payment_method}' == 'ShopeePay'   Get Text And Compare    ${passes_buypass_method_desc['${mobile}']}   	Pay with E-wallet

    Get Text And Compare    ${passes_buypass_method_name['${mobile}']}   ${payment_method}
    Continue To Pay

Continue To Pay

    Wait Element And Click Element  ${passes_buypass_pay['${mobile}']}

Check Not Downloaded Yet Dialog

    Verify Element Display  ${passes_no_download_dialog['${mobile}']}
    Get Text And Compare   ${passes_no_download_title['${mobile}']}  Not downloaded any films yet
    Verify Element Display  ${passes_no_download_find['${mobile}']}
    Verify Element Display  ${passes_no_download_continue['${mobile}']}
    Wait Element And Click Element  ${passes_no_download_find['${mobile}']}
    Verify Element Display  ${location_location_btn['${mobile}']}
    Click Passes Main Tab

Check Transaction Dialog

    #Buy Pass dialog
    Log to Console  Buy pass by cash, check the transaction Dialog and cancel it!
    ##Note : Due to this dialog issue, checking whole item coat much time....(need to investigate)
    # Verify Element Display  ${passes_buy_dialog['${mobile}']}
    # Verify Element Display  ${passes_buy_dialog_icon['${mobile}']}
    # Get Text And Compare    ${passes_buy_dialog_title['${mobile}']}   Buy Migo Pass
    # Get Text And Compare    ${passes_buy_dialog_subtitle['${mobile}']}   	Show code to Migo Retailer
    #Verify Element Display  ${passes_buy_dialog_transaction_code['${mobile}']}
    # Verify Element Display  ${passes_buy_dialog_expired_time['${mobile}']}
    # Get Text And Compare    ${passes_buy_dialog_item['${mobile}']}   	Purchase Item
    # Get Text And Compare    ${passes_buy_dialog_item_value['${mobile}']}   	Paket 30 Hari
    # Get Text And Compare    ${passes_buy_dialog_total['${mobile}']}   Total
    # Get Text And Compare    ${passes_buy_dialog_total_value['${mobile}']}   	Rp 30.000
    # Get Text And Compare    ${passes_buy_dialog_transaction_id['${mobile}']}    Transaction ID   
    # Verify Element Display    ${passes_buy_dialog_transaction_id_value['${mobile}']}   	
    # Verify Element Display    ${passes_buy_dialog_find_mds_cta['${mobile}']}   	
    Verify Element Display  ${passes_buy_dialog_cancel['${mobile}']}

Cancel Transaction Dialog

    Log to Console  Buy pass by cash, check the transaction Dialog and cancel it!  	
    Wait Element And Click Element  ${passes_buy_dialog_cancel['${mobile}']}


Buy and Active Ticket on Mitra Sell Pass 

    ${text_code}    Wait Element And Get Text   ${passes_buy_dialog_transaction_code['${mobile}']}	

    Confirm Cash Transaction of Buy Migo Passes  ${text_code}
    Sleep  1s
    Verify Element Display  ${passes_buy_dialog_completed_purchase['${mobile}']}
    Wait Element And Click Element  ${passes_buy_dialog_view_btn['${mobile}']}

    Get Text And Compare    ${passes_migo_passes_status['${mobile}']}   Activate Your Pass
    Wait Element And Click Element  ${passes_my_passes_active_pass_btn['${mobile}']}
    Verify Element Display  ${passes_my_passes_active_pass_dialog['${mobile}']}
    Wait Element And Click Element  ${passes_my_passes_active_pass_dialog_active_btn['${mobile}']}

    #Buy successfully
    Get Text And Compare    ${passes_migo_passes_status['${mobile}']}   Last Day

    [Return]    ${text_code}