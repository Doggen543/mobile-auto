*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
Resource          ..${/}utility${/}utility_keywords.robot
Variables         ..${/}elements${/}migo_location_page.yaml
Variables         ..${/}elements${/}migo_auth_page.yaml

*** Keywords ***
Click Location Main Tab

    Log to console  Swtich to Location Main Tab 
    Wait Element And Click Element  ${location_main_tab['${mobile}']}
    #Verify Element Display  ${location_location_btn['${mobile}']}

Check the Onboard Location Tutorials

    [Documentation]
    ...
    ...    Check Location Onboard Tutorials 
    ...   

    Click Location Main Tab
    Verify Element Display  ${location_onboard_tutorials_skip['${mobile}']}
    Verify Element Display  ${location_onboard_tutorials_title['${mobile}']}
    Verify Element Display  ${location_onboard_tutorials_desc['${mobile}']}
    Wait Element And Click Element  ${location_onboard_tutorials_btn['${mobile}']}
    Verify Element Display  ${location_list_btn['${mobile}']}

Reading Location Tutorials  

    Wait Element And Click Element  ${location_tutorials_btn['${mobile}']}
    Wait Element And Click Element  ${location_tutorials_next_btn['${mobile}']}
    Wait Element And Click Element  ${location_tutorials_next_btn['${mobile}']}
    Wait Element And Click Element  ${location_tutorials_next_btn['${mobile}']}
    Wait Element And Click Element  ${location_tutorials_MDS_btn['${mobile}']}

Check Finding Migo MDS 

    Wait Element And Click Element  ${location_list_btn['${mobile}']}
    Wait Element And Click Element  ${location_map_btn['${mobile}']}
    Wait Element And Click Element  ${location_list_btn['${mobile}']}
    #Verify Element Display  ${location_location_icon['${mobile}']}

    Verify Element Display  ${location_location_icon['${mobile}']}
    Wait Element And Click Element  ${location_warung_migo['${mobile}']}

    Verify Element Display  ${location_warung_title['${mobile}']}
    Verify Element Display  ${location_warung_name['${mobile}']}
    Verify Element Display  ${location_warung_show_btn['${mobile}']}
    Wait Element And Click Element  ${location_back_btn['${mobile}']}
    Wait Element And Click Element  ${location_back_btn['${mobile}']}