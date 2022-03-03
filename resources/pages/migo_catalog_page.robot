*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
Resource          ..${/}utility${/}utility_keywords.robot
Variables         ..${/}elements${/}migo_catalog_page.yaml
Variables         ..${/}elements${/}migo_auth_page.yaml

*** Variables ***
${content_preference}       //*[contains(@text, '$genres')]

*** Keywords ***
Click Catalog Main Tab

    Log to console  Swtich to Catalog Main Tab 
    Wait Element And Click Element  ${catalog_main_tab['${mobile}']}

Choose User Genres

    [Arguments]     ${genre1}   ${genre2}   ${genre3}   
    [Documentation]
    ...
    ...    Choose three of content prefernce
    ...     

    Verify Element Display  ${auth_genre_title['${mobile}']}
    
    #Content Preference
    Verify Element Display  ${auth_genres_Drama['${mobile}']}
    Verify Element Display  ${auth_genres_Petualangan['${mobile}']}
    Verify Element Display  ${auth_genres_Keluarga['${mobile}']}
    Verify Element Display  ${auth_genres_Aksi['${mobile}']}
    Verify Element Display  ${auth_genres_Horor['${mobile}']}
    Verify Element Display  ${auth_genres_Komedi['${mobile}']}
    Verify Element Display  ${auth_genres_Anime['${mobile}']}
    Verify Element Display  ${auth_genres_Reality['${mobile}']}
    Verify Element Display  ${auth_genres_Anakanak['${mobile}']}
    Verify Element Display  ${auth_genres_Romansa['${mobile}']}
    Verify Element Display  ${auth_genres_Edukasi['${mobile}']}
    Verify Element Display  ${auth_genres_KDrama['${mobile}']}

    ${genre_1}=    Replace String 	${content_preference}    $genres	  ${genre1}
    ${genre_2}=    Replace String 	${content_preference}    $genres   ${genre2}
    ${genre_3}=    Replace String 	${content_preference}    $genres	  ${genre3}
       
    #Choose Genres
    Wait Element And Click Element  ${genre_1}
    Wait Element And Click Element  ${genre_2}
    Wait Element And Click Element  ${genre_3}
    Sleep  1s
    Wait Element And Click Element  ${auth_genre_btn['${mobile}']}

Click Coach Icon

    [Documentation]
    ...
    ...    Click OK on Coach
    ...   

    Verify Element Display  ${auth_coach_section['${mobile}']}
    Wait Element And Click Element  ${auth_coach_ok['${mobile}']}

Add To Saved Items On Title Card   
    [Documentation]
    ...
    ...     Add to my Favorite video saved 
    ...     
    #Favorite save later
    Wait Element And Click Element  ${catalog_titlecard_savelater['${mobile}']}
    Verify Element Display  ${catalog_successful_save_bar['${mobile}']}


Remove To Saved Items On Title Card   
    [Documentation]
    ...
    ...     Remove to my Favorite video saved 
    ...     
    #Favorite save later
    Wait Element And Click Element  ${catalog_titlecard_savelater['${mobile}']}
    Press Keycode   4
    Verify Element Not Display  ${catalog_mysaved_item_section['${mobile}']}

Check My Saved Items 
    [Arguments]     ${saved_items}     
    [Documentation]
    ...
    ...     Check my Favorite video saved correctly
    ...     

    Click Catalog Main Tab
    Wait Element And Click Element  ${catalog_mysaved_item_section['${mobile}']}
    Sleep  1s
    Wait Element And Click Element  ${catalog_mysaved_item_video_asset['${mobile}']}
    Get Text And Compare    ${catalog_titlecard_name['${mobile}']}   ${saved_items} 

Check Catalog Page
    [Documentation]
    ...
    ...    Image and field on Catalog
    ...     
    Log to console  User on Catalog Page
    Verify Element Display  ${catalog_carousel['${mobile}']}
    Verify Element Display  ${catalog_migo_personal_recommendation['${mobile}']}
    Verify Element Display  ${catalog_migo_personal_recommendation_all['${mobile}']}
    Verify Element Display  ${catalog_migo_famous_movie['${mobile}']}
    Verify Element Display  ${catalog_migo_famous_movie_all['${mobile}']}
    Verify Element Display  ${catalog_migo_famous_series['${mobile}']}
    Verify Element Display  ${catalog_migo_famous_series_all['${mobile}']}

Search Video
    [Arguments]     ${search_name}     
    [Documentation]
    ...
    ...     Search video and check title card
    ...     

    #Search
    Log to console  Search "${search_name}"
    Wait Element And Click Element  ${catalog_searchbtn['${mobile}']}
    Verify Element Display  ${catalog_searchvideopage['${mobile}']}
    Verify Element Display  ${catalog_genres_comedy['${mobile}']}
    Verify Element Display  ${catalog_genres_kids['${mobile}']}

    Verify Element Display  ${catalog_trending['${mobile}']}
    Verify Element Display  ${catalog_trending_list['${mobile}']}

    Wait Element And Click Element  ${catalog_searchfield['${mobile}']}
    Wait Element And Input    ${catalog_searchfield['${mobile}']}    ${search_name}

    #Title Card
    Wait Element And Click Element  ${catalog_video_search['${mobile}']}

Verify Title Card

    Verify Element Display  ${catalog_titlecard_name['${mobile}']}
    Verify Element Display  ${catalog_titlecard_video_info['${mobile}']}
    Verify Element Display  ${catalog_titlecard_synopsis['${mobile}']}
    Verify Element Display  ${catalog_titlecard_savelater['${mobile}']}
    Verify Element Display  ${catalog_titlecard_download_btn['${mobile}']}

    Wait Element And Click Element  ${catalog_titlecard_seemore['${mobile}']}
    Verify Element Display  ${catalog_titlecard_subtitle['${mobile}']}
    Verify Element Display  ${catalog_titlecard_audio['${mobile}']}

    Wait Element And Click Element  ${catalog_titlecard_seeless['${mobile}']}
    Verify Element Not Display  ${catalog_titlecard_subtitle['${mobile}']}
    Verify Element Not Display  ${catalog_titlecard_audio['${mobile}']}

Search By Geners
    [Arguments]     ${genres}
    [Documentation]
    ...
    ...    Search Video with name and Check the Title card 
    ...     
    Log to console  Search the "${genres}"
    Wait Element And Click Element  ${catalog_searchbtn['${mobile}']}

    ${search_genres}=    Replace String 	${search_by_genres}    $genres	  ${genres}

    Wait Element And Click Element  ${search_genres}