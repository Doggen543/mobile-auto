*** Settings ***
Resource          ..${/}..${/}resources${/}variables.resource
Resource          ..${/}..${/}resources${/}libraries.resource
Resource          ..${/}..${/}resources${/}utility${/}utility_keywords.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_sell_pass.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_auth_page.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_account_page.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_catalog_page.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_passes_page.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_downloads_page.robot
Resource          ..${/}..${/}resources${/}pages${/}migo_location_page.robot
Variables         ..${/}..${/}resources${/}elements${/}migo_auth_page.yaml
Variables         ..${/}..${/}resources${/}elements${/}migo_catalog_page.yaml
Variables         ..${/}..${/}resources${/}elements${/}migo_downloads_page.yaml
Variables         ..${/}..${/}resources${/}elements${/}migo_location_page.yaml
Variables         ..${/}..${/}resources${/}elements${/}migo_passes_page.yaml
Variables         ..${/}..${/}resources${/}elements${/}migo_account_page.yaml


*** Variables ***


*** Test Cases ***
New User Onboard Tutorials and Buy Ticket to Check Transaction History
    [Tags]    e2e   newuser            

    [Setup]    Launch Migo  Samsung_A505    true
    [Teardown]    Close Application         
     
    Eliminate Test Account   +62     99999999999  
    Allow Device Permission
    Browse Catalog First
    Choose User Genres      Komedi      Anime       Reality  
    ${timer1}=    Get Current Date  
    Click Coach Icon
    Verify Element Display  ${catalog_carousel['${mobile}']}
    ${timer2}=    Get Current Date

    Check the Onboard Location Tutorials
    Check the Onboard Passes Tutorials

    Login Migo Account   +62     99999999999     
    Check Hello Profile Page   
    Check First Download Page

    Click Passes Main Tab
    Check Buy Migo Pass Dialog  Paket 1 Hari    Rp 3.000   Cash  
    Continue To Pay
    
    #text_code -> Transaction code on web(buy pass) and history
    ${text_code}=  Buy and Active Ticket on Mitra Sell Pass   

    Click Account Main Tab
    Check Transaction History   Paket 1 Hari    Cash    ${text_code}   Rp 3.000    Succeed

    #Info
    #Layout/Asset API 
    ${time_catalog}=	Subtract Date From Date     ${timer2}        ${timer1}
    Log to console  \nUser took ${time_catalog}s hours to see the full catalog page.
    ${version}=   Get Daily Build Hash
    Log to console  \nDaily Build Hash ${version}

    Logout

    #Account Reset
    #curl -u account:accountr00t https://api-account.migosrv-staging.com/api/admin/accounts -XDELETE --data '{ "country_code": "+62", "phone_number": "99999999999" }'
    #Eliminate Test Account   +62     99999999999

Login Exist User and Check Data Restore 
    [Tags]    e2e   existuser     data              

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]     Run Keywords     Logout     AND    Close Application     

    Choose User Genres      Komedi      Anime       Reality  

    Click Account Main Tab
    Login Migo Account   +62     99999999998     

    Check User Profile Information Storage
    User Press Back Key
    User Press Back Key

    Log to console  Payment Method
    Check Payment Method

    Log to console  Check Parental Control
    Check Parental Control  D17+
    User Press Back Key

    Log to console  Check Download Queue
    Check Download Queue    ${my_download_queue}

    Check My Saved Items    ${my_saved_items}
    User Press Back Key

    Click Account Main Tab
    Migo Point Should Not Be Zero

Catalog Page and Video Search Happy Path
    [Tags]    Catalog     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505    true    
    [Teardown]    Close Application

    Allow Device Permission
    Register or Login First     +62     99999999997  

    Click Coach Icon
    Check the Onboard Location Tutorials
    Check the Onboard Passes Tutorials

    Click Catalog Main Tab

    Check Catalog Page

    Search Video    ${search_name} 
    Verify Title Card
    Add To Saved Items On Title Card   

Catalog Page and Saved Items Happy Path
    [Tags]    Catalog     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Click Account Main Tab

    Check My Saved Items    ${search_name} 
    Remove To Saved Items On Title Card


Downloan Page Happy Path 
    [Tags]    Downloan     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Check First Download Page
    #Downloan Video

    Click Downloads Main Tab
    Check File Manager
    Delete All Download Video
    Reading Download Tutorials


Location Page Happy Path
    [Tags]    Location     e2e   existuser       
  
    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application


    Click Location Main Tab
    Reading Location Tutorials 
    Check Finding Migo MDS 

    
Passes Page Happy Path
    [Tags]    Passes     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Click Passes Main Tab
    Check Passes Price
    Check My passes Empty
    Redeem Promocode    migoqa2022
    Activate Pass   Last Day

Check Payment Method Flow 
    [Tags]    Passes     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Click Passes Main Tab
    Check MDS Far Dialog

    Click Passes Main Tab
    Check Buy Migo Pass Dialog  Paket 7 Hari    Rp 10.000   Cash  
    Check Payment Method Options
    Select Payment Method   ShopeePay

    Check Not Downloaded Yet Dialog
    Check Buy Migo Pass Dialog  Paket 30 Hari    Rp 30.000   ShopeePay


Cancel Cash Transaction Flow 
    [Tags]    Passes     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Click Passes Main Tab
    Check Buy Migo Pass Dialog  Paket 7 Hari    Rp 10.000   ShopeePay  
    Check Payment Method Options
    Select Payment Method   Cash

    Cancel Transaction Dialog


Account Page Happy Path
    [Tags]    Passes     e2e   existuser       

    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Click Account Main Tab
    Check Account Main Tab After Login

    Change User Profile Information Referral Code 
    Check My Migo Reward Page
    User Press Back Key

    Check Migo App Tutorail
    Check Help Center


#Please make sure you run this test case under public wifi and login
Exist User Change Network, Download Video and Play the Video
    [Tags]    networkswitch     e2e   existuser     demo          
    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Change debug Recording Prevention

    Search Video    Skakmat
    Click Download Button on Movie Title Card

    Chick Download Bar To Download Page

    Change Wifi From Public To MDS
    
    #Verify Video is play!
    ${video_name}=    Set Variable     Skakmat 
    ${obb_info}=    Create Dictionary    obb_info1=Migo    obb_info2=DIPERSEMBAHKAN OLEH       obb_info3=Ini, cara baru.       obb_info4=VISION
    Play and Check Video    ${video_name}   ${obb_info}
    Log to Console  Video Checking Successfully!!!

Parental Control Happy Path
    [Tags]    parental     e2e   existuser  demo
    [Setup]    Launch Migo  Samsung_A505
    [Teardown]    Close Application

    Click Account Main Tab
    Check Parental Control Page

    Set Parental Control
    Set PIN Code  5   5   6   6
    Confirm PIN Code with Error  5    5    6    7 
    Confirm PIN Code    5   5   6   6

    Check Default Restriction
    Set Content Restriction     D17+

    Change Restriction  R13+   5   5   6   6

    Reset PIN Code   5   5   6   6
    Set PIN Code    7   7   8   8
    Confirm PIN Code    7   7   8   8

    User Press Back Key
    Click Downloads Main Tab
    Play and Check Video With PIN Code  7   7   8   8
    Sleep  2s
    AppiumLibrary.Capture Page Screenshot   Parental_Enable.png

    User Press Back Key
    # Wait Element And Click Element  ${downloads_video_surfaceView['${mobile}']}    
    # AppiumLibrary.Click Element At Coordinates      1180    580 
    # Wait Element And Click Element  ${downloads_video_forward_btn['${mobile}']} 
    Click Account Main Tab
    Close Parental Control  7   7   8   8

    User Press Back Key
    Click Downloads Main Tab
    Wait Element And Click Element  ${downloads_play_video_icon['${mobile}']}
    Verify Element Not Display  ${account_parental_set_pin_field1['${mobile}']}
    Sleep  2s
    AppiumLibrary.Capture Page Screenshot   Parental_Disable.png

Catalog Page Display under MDS Wifi
    [Tags]    e2e   MDS     wifi    demo        

    [Setup]    Launch Migo  Samsung_A505    true
    [Teardown]    Close Application         
     
    Allow Device Permission
    Browse Catalog First
    Choose User Genres      Komedi      Anime       Reality  
    ${timer1}=    Get Current Date  
    Click Coach Icon
    Verify Element Display  ${catalog_carousel['${mobile}']}
    ${timer2}=    Get Current Date

    Login Migo Account   +62     99999999998    
    Check User Profile Information Storage 

    #Layout/Asset API 
    #Check the Catalog Showing direly on user UI
    ${time_catalog}=	Subtract Date From Date     ${timer2}        ${timer1}
    Log to console  \nUser took ${time_catalog}s hours to see the full catalog page.




