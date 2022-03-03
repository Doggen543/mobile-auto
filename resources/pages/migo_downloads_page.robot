*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
Resource          ..${/}utility${/}utility_keywords.robot
Variables         ..${/}elements${/}migo_downloads_page.yaml
Variables         ..${/}elements${/}migo_catalog_page.yaml
Variables         ..${/}elements${/}migo_location_page.yaml
Variables         ..${/}elements${/}migo_auth_page.yaml

*** Variables ***
${search_by_genres}       //*[contains(@text, '$genres')]

*** Keywords ***
Click Downloads Main Tab

    Log to console  Swtich to Downloads Main Tab 
    Wait Element And Click Element  ${downloads_main_tab['${mobile}']}
    Verify Element Display  ${downloads_page_title['${mobile}']}
    Verify Element Display  ${downloads_file_manager['${mobile}']}
    Verify Element Display  ${downloads_tutorials_btn['${mobile}']}

Check First Download Page

    #Download video to check the download successfully page
    Log to console  Verify First Download Page
    Wait Element And Click Element  ${catalog_main_tab['${mobile}']}

    Search By Geners    Kids
    Click The Search By Geners Title Card 
    Click Download Button on Movie Title Card

    Verify Element Display  ${downloads_first_download_page_title['${mobile}']}
    Verify Element Display  ${downloads_first_download_page_subtitle['${mobile}']}
    Verify Element Display  ${downloads_first_download_page_img['${mobile}']}
    Wait Element And Click Element  ${downloads_first_download_page_btn['${mobile}']}

    Verify Element Display  ${downloads_page_title['${mobile}']}
 

Click The Search By Geners Title Card 
    [Documentation]
    ...
    ...    Title Card on the left Top corner
    ...  

    Log to console  Click Search By Geners Title Card
    Wait Element And Click Element  ${catalog_genres_video['${mobile}']}

Click Download Button on Movie Title Card
    [Documentation]
    ...
    ...    Download "Movie" Button
    ... 

    Sleep  2s
    Wait Element And Click Element  ${catalog_titlecard_download_btn['${mobile}']}

Check File Manager

    Log to console  Go to File Manager
    Wait Element And Click Element  ${downloads_file_manager['${mobile}']}
    Verify Element Display  ${downloads_manage_migo_files_title['${mobile}']}

    Verify Element Display  ${downloads_manage_migo_files_internalstorage['${mobile}']}
    Verify Element Display  ${downloads_manage_migo_files_migo['${mobile}']}
    Verify Element Display  ${downloads_manage_migo_files_otherfiles['${mobile}']}
    Verify Element Display  ${downloads_manage_migo_files_free['${mobile}']}

    Wait Element And Click Element  ${downloads_manage_migo_files_deletebtn['${mobile}']}
    Verify Element Display  ${downloads_delete_popup_title['${mobile}']}
    Wait Element And Click Element  ${downloads_delete_popup_cancel['${mobile}']}
    
    Wait Element And Click Element  ${downloads_manage_migo_files_close['${mobile}']}

Delete All Download Video

    Wait Element And Click Element  ${downloads_file_manager['${mobile}']}
    Wait Element And Click Element  ${downloads_manage_migo_files_deleteall['${mobile}']}
    Verify Element Display  ${downloads_delete_popup_title['${mobile}']}
    Wait Element And Click Element  ${downloads_delete_popup_delete['${mobile}']}
    Wait Element And Click Element  ${downloads_manage_migo_files_close['${mobile}']}

    Verify Element Display  ${downloads_no_any_movies_text['${mobile}']}
    Verify Element Display  ${downloads_no_any_movies_btn['${mobile}']}

Reading Download Tutorials

    Log to console  Reading Download Tutorials
    Wait Element And Click Element  ${downloads_tutorials_btn['${mobile}']}
    Wait Element And Click Element  ${downloads_tutorials_next_btn['${mobile}']}
    Wait Element And Click Element  ${downloads_tutorials_next_btn['${mobile}']}
    Wait Element And Click Element  ${downloads_tutorials_next_btn['${mobile}']}
    Wait Element And Click Element  ${downloads_tutorials_MDS_btn['${mobile}']}
    Verify Element Display  ${location_location_btn['${mobile}']}


Chick Download Bar To Download Page

    Verify Element Display  ${catalog_successful_download_bar['${mobile}']}
    Wait Element And Click Element  ${catalog_bar_view['${mobile}']}
    
    Verify Element Display  ${downloads_page_title['${mobile}']}
    # Verify Element Display  ${downloads_wifi_remind_alert['${mobile}']}
    # Verify Element Display  ${downloads_wifi_remind_title['${mobile}']}
    # Verify Element Display  ${downloads_wifi_remind_learnmore['${mobile}']}

Play and Check Video 

    [Arguments]     ${video_name}   ${obb_info}  
    [Documentation]
    ...
    ...    Play and Check Video, surfaceview and video info
    ...     

    ${datetime}=    Get Current Date
    Wait Element And Click Element  ${downloads_play_video_icon['${mobile}']}    300
    Sleep  3s
    #
    AppiumLibrary.Capture Page Screenshot   video_${datetime}_1.png

    Log to Console   Executing the  Optical Character Recognition(OCR) => OBB Checking...
    ${processed_img}=     Read Image    video_${datetime}_1.png
    ${content}=   Get Image Content   ${processed_img}    --psm 11   eng
    #Vision...

    # Should Contain     ${content}     DIPERSEMBAHKAN OLEH  
    # Should Contain     ${content}     Migo
    # Should Contain     ${content}     VISION 
    # Should Contain     ${content}     Ini, cara baru.  
    FOR    ${i}    IN    @{obb_info}
        Should Contain     ${content}     ${obb_info['${i}']} 
    END


    ${current_activity}=  Get Activity
    Should Be Equal    ${current_activity}    .ui.activity.nowplaying.ExoNowPlayingActivity
    Log to Console  Current Activity is : ${current_activity}
    Sleep  6s
    
    # Wait Element And Click Element  ${downloads_video_surfaceView['${mobile}']}    
    # AppiumLibrary.Click Element At Coordinates      1180    580

    # Get Text And Compare    ${downloads_video_title['${mobile}']}   ${video_name}
    # Verify Element Display  ${downloads_video_play_btn['${mobile}']}   
    # Verify Element Display  ${downloads_video_seekbar['${mobile}']}   
    # Wait Element And Click Element  ${downloads_video_forward_btn['${mobile}']} 
    # Sleep  1s
    AppiumLibrary.Capture Page Screenshot   video_${datetime}_2.png 

    # Wait Element And Click Element  ${downloads_play_back_btn['${mobile}']} 

Check Download Queue

    [Arguments]     ${video_name}  
    [Documentation]
    ...
    ...    Check Download Queue for Restoration
    ...     

    Wait Element And Click Element  ${downloads_main_tab['${mobile}']}
    Get Text And Compare    ${downloads_saved_queue['${mobile}']}   ${video_name}
