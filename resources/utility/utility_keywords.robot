*** Settings ***
Resource          ..${/}variables.resource
Resource          ..${/}libraries.resource
# Resource          ..${/}keywords.resource
Variables         desired_capabilities.yaml

*** Keywords ***
#===Web===
#Time
Convert Date To ddMMyyyy
    [Arguments]     ${date}     ${padZero}=${TRUE}
    [Documentation]    Converts a robot framework datetime to a string in format dd MMM yyyy.
    ...
    ...    Parameters:
    ...        | *date*     | The date to convert |
    ...        | *padDayWithZeroes* | Pad day with zeroes (Ex: "01 January 2017" instead of "1 January 2017"). |
    ...
    ...    Examples:
    ...        | Convert Date To ddMMyyyy | 2000-01-01 |
    ${monthList} =    Create List    January    February    March    April    May    June    July    August    September    October    November    December

    ${datetime} =    Convert Date    ${date}    datetime
    ${date_day} =    Set Variable If    ${datetime.day} < 10    0${datetime.day}    ${datetime.day}
    #${date_day} =    Set Variable If    ${datetime.day} >= 10    ${datetime.day}    ${datetime.day}   
    
    #${datetime.month}
    ${month}=   convert to integer  ${datetime.month}
    ${month}=   Evaluate    ${month} - 1

    ${date_return} =    Set Variable    ${date_day} ${monthList}[${month}] ${datetime.year}  

    [Return]    ${date_return}
#Browser
Open Page
    [Arguments]     ${url}    ${browser}    ${alias}=${EMPTY}
    [Documentation]    Wrapper around the Open Browser keyword from SeleniumLibrary.
    ...    Opens a browser and loads a page.
    ...    It then maximizes the browser window.
    ...
    ...    Parameters:
    ...        | *url* | The URL to open |
    ...        | *browser* | The browser to use. Uses the same values as the browser parameter from the Open Browser keyword. |
    ...
    ...    Examples:
    ...        | Open Page | https://www.google.com | chrome |

    Log To Console    Open Page :: Test URL = ${url}
    Log To Console    Open Page :: Browser = ${browser}

    # Open Specific Browser
    ${match}  ${value}  Run Keyword And Ignore Error  Should Contain Any  ${browser}  chrome   gc  googlechrome
    Run Keyword If  '${match}' == 'PASS'
    ...     Run Keyword
    ...     Open Chrome  ${url}  ${browser}  ${alias}

    ${match}  ${value}  Run Keyword And Ignore Error  Should Contain Any  ${browser}  firefox  ff
    Run Keyword If  '${match}' == 'PASS'
    ...     Run Keyword
    ...     Open Firefox  ${url}  ${browser}  ${alias}


    Set Window Size  1440   900

Open Chrome
    [Arguments]    ${url}  ${browser}   ${alias}=None
    [Documentation]    
    ...    
    ...    add_argument for browser
    ...

    ${options}=   Evaluate   sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
    #Call Method    ${options}    add_argument    --lang\=${LANGUAGE}
    Call Method    ${options}    add_argument    --enable-features\=NetworkService,NetworkServiceInProcess
    Call Method    ${options}    add_argument    --incognito

    Run Keyword If  '${browser}' == 'headlesschrome'
    ...   Run Keywords
    ...   Call Method    ${options}   add_argument    --headless
    ...   AND
    ...   Call Method    ${options}    add_argument    --disable-gpu
    ...   AND
    ...   Call Method    ${options}    add_argument    --disable-dev-shm-usage
    ...   AND
    ...   Call Method    ${options}    add_argument    --no-sandbox
    ...   AND
    ...   Call Method    ${options}    add_argument    --start-maximized

    Create WebDriver   Chrome   alias=${alias}   chrome_options=${options}
    Go To   ${url}


Input Data
    [Arguments]    ${locator}   ${data}
    [Documentation]    Wrapper around the Input Text keyword that clears the field first.
    ...
    ...    Parameters:
    ...        | *dataLocator* | The locator of the input field |
    ...        | *data* | The data to input |
    ...    Examples:
    ...        | Input Data | id=myInput | textToInput |


    SeleniumLibrary.Wait Until Element Is Visible	${locator}      ${timeout}
    SeleniumLibrary.Input Text     ${locator}    ${data}
    Log To Console    Input Data with value = ${data}


Submit Button
    [Arguments]     ${locator}
    [Documentation]    Wrapper around the Click Element keyword.
    ...
    ...    Parameters:
    ...        | *locator*   | The locator of the button or element field |
    ...    Examples:
    ...        | Submit Button | id=myInput |

    SeleniumLibrary.Wait Until Element Is Visible	    ${locator}  ${timeout}
    SeleniumLibrary.Wait Until Element Is Enabled	    ${locator}  ${timeout}
    SeleniumLibrary.Click Element   ${locator}


#===App===
Launch Migo
    [Arguments]     ${device_name}   ${reset}=false
    [Documentation]
    ...
    ...    Launch Migo App
    ...

    Set Log Level    TRACE

    Log    Environment set up...     html=True    console=True    level=TRACE

    Run Keyword If    '${reset}' == 'true'
    ...    Starting Appium Server With Reset Data    migo    ${device_name}
    ...    ELSE         Starting Appium Server    migo    ${device_name}

    ${sut}    Run Keyword If    type($device_name) is dict
    ...    Evaluate    list($device_name.keys())[0]
    ...    ELSE    Set Variable    ${device_name}
    Set Test Variable    ${device_name}    ${sut}

    Log to console  Migo APP Launch!!!
    Wait Migo Animation Splash


Starting Appium Server
    [Arguments]     ${APP_NAME}    ${device_name}
    [Documentation]
    ...
    ...    ``APP_NAME`` (case insensitive) 啟動的 app , EX: migo 
    ...      noReset=true, the application data will not be clear 
    ...

    Set Log Level    TRACE

    ${appium_session_id}    Get Current Date    result_format=epoch    exclude_millis=yes
    ${appium_session_id}    Convert To String    ${appium_session_id}

    ${mobile}    Convert To Lower Case    android
    ${mobile_env}    Create List    android    ios
    Run Keyword If    '${mobile}' not in ${mobile_env}    Fatal Error    Invalid mobile value!!! Valid value is ${mobile_env}
    Run Keyword If    '${mobile}' == 'ios'    Fatal Error    NotImplementedError
    Set Test Variable    ${mobile}    ${mobile}

    ${sut}    Run Keyword If    type($device_name) is dict
    ...    Evaluate    $CONNECT_DEVICES[list($device_name.keys())[0]]
    ...    ELSE    Set Variable    ${CONNECT_DEVICES['${device_name}']}
    Set Test Variable    ${sut}    ${sut}


    ${ip_and_port}    get_ip_and_free_port
    Log    Create Appium session and launch server...    html=True    console=True
    Start Process    appium -a ${ip_and_port['ip']} -p ${ip_and_port['port']}
    ...    shell=True    alias=${appium_session_id}
    Wait For Process    ${appium_session_id}    timeout=10s
    Log    Appium Server listening port: ${ip_and_port['port']}...    html=True    console=True

    ${platfrom_version}    Run Keyword If    '${mobile}' == 'android'
    ...    Run Process    adb -s ${sut} shell getprop ro.build.version.release    shell=True

    Log    Launch ${APP_NAME} on device: ${device_name}    html=True    console=True
    Open Application    http://${ip_and_port['ip']}:${ip_and_port['port']}/wd/hub
    ...    platformName=${platform_name['${mobile}']}
    ...    chromedriverExecutable=${CURDIR}/chromedriver
    ...    platformVersion=${platfrom_version.stdout}        
    ...    noReset=true
    ...    automationName=${automation_name['${mobile}']}
    ...    newCommandTimeout=180  
    ...    recreateChromeDriverSessions=${True}
    ...    udid=${sut}    
    # ...    autoGrantPermissions=true
    # ...    fullReset=true
    ...    appPackage=com.migo.androidplayer
    ...    appActivity=${app_activity['${APP_NAME}']['${mobile}']}  

    Launch Application

    Set Test Variable    ${from_aoa}    ${None}
    Set Test Variable    ${via_timeline_card}    ${None}

Starting Appium Server With Reset Data
    [Arguments]     ${APP_NAME}    ${device_name}
    [Documentation]
    ...
    ...    ``APP_NAME`` (case insensitive) 啟動的 app , EX: migo
    ...      noReset=true, the application data will be CLEAR!!! 
    ...

    Set Log Level    TRACE

    ${appium_session_id}    Get Current Date    result_format=epoch    exclude_millis=yes
    ${appium_session_id}    Convert To String    ${appium_session_id}

    ${mobile}    Convert To Lower Case    android
    ${mobile_env}    Create List    android    ios
    Run Keyword If    '${mobile}' not in ${mobile_env}    Fatal Error    Invalid mobile value!!! Valid value is ${mobile_env}
    Run Keyword If    '${mobile}' == 'ios'    Fatal Error    NotImplementedError
    Set Test Variable    ${mobile}    ${mobile}

    ${sut}    Run Keyword If    type($device_name) is dict
    ...    Evaluate    $CONNECT_DEVICES[list($device_name.keys())[0]]
    ...    ELSE    Set Variable    ${CONNECT_DEVICES['${device_name}']}
    Set Test Variable    ${sut}    ${sut}

    ${ip_and_port}    get_ip_and_free_port
    Log    Create Appium session and launch server...    html=True    console=True
    Start Process    appium -a ${ip_and_port['ip']} -p ${ip_and_port['port']}
    ...    shell=True    alias=${appium_session_id}
    Wait For Process    ${appium_session_id}    timeout=10s
    Log    Appium Server listening port: ${ip_and_port['port']}...    html=True    console=True

    ${platfrom_version}    Run Keyword If    '${mobile}' == 'android'
    ...    Run Process    adb -s ${sut} shell getprop ro.build.version.release    shell=True

    Log    Launch ${APP_NAME} on device: ${device_name}    html=True    console=True
    Open Application    http://${ip_and_port['ip']}:${ip_and_port['port']}/wd/hub
    ...    platformName=${platform_name['${mobile}']}
    ...    chromedriverExecutable=${CURDIR}/chromedriver
    ...    platformVersion=${platfrom_version.stdout}        
    ...    noReset=false
    ...    automationName=${automation_name['${mobile}']}
    ...    newCommandTimeout=180  
    ...    recreateChromeDriverSessions=${True}
    ...    udid=${sut}    
    # ...    autoGrantPermissions=true
    # ...    fullReset=true
    ...    appPackage=com.migo.androidplayer
    ...    appActivity=${app_activity['${APP_NAME}']['${mobile}']} 

    Launch Application

    Set Test Variable    ${from_aoa}    ${None}
    Set Test Variable    ${via_timeline_card}    ${None}

Wait Migo Animation Splash
    [Documentation]
    ...
    ...    activity : com.migo.androidplayer.ui.activity.splash.SplashActivity
    ...

    sleep  8s

Verify Element Display
    [Arguments]     ${locator}    ${wait_time}=15s
    [Documentation]
    ...
    ...  Element should display
    ...

    Run Keyword If    type($locator) is str     AppiumLibrary.Wait Until Page Contains Element    ${locator}    ${wait_time}

Verify Element Not Display
    [Arguments]     ${locator}    ${wait_time}=15s
    [Documentation]
    ...
    ...  Element should not display
    ...

    Run Keyword If    type($locator) is str     AppiumLibrary.Wait Until Page Does Not Contain    ${locator}    ${wait_time}


Scroll To Element And Click
    [Arguments]    ${locator}   
    [Documentation]
    ...
    ...  Scroll by using coordinate and Click()
    ...

    #Scroll Down
    FOR    ${i}    IN RANGE    10 
        ${visible}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible
        ...    ${locator}
        Exit For Loop If    ${visible}
        #start_x start_y offset_x offset_y duration 
        Swipe    500    1200    500    850    1000
    END

    Wait Element And Click Element  ${locator}   

Scroll To Element And Check
    [Arguments]    ${locator}   
    [Documentation]
    ...
    ...  Scroll by using coordinate and Until Element Is Visible
    ...

    #Scroll Down
    FOR    ${i}    IN RANGE    10
        ${visible}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible
        ...    ${locator}
        Exit For Loop If    ${visible}
        #start_x start_y offset_x offset_y duration 
        Swipe    500    1200    500    850    1000
    END

    Run Keyword If    type($locator) is str     AppiumLibrary.Wait Until Page Contains Element    ${locator}    ${wait_time}

Send Request
    [Arguments]     ${method}    ${uri}    ${kwargs}=${None}
    [Documentation]
    ...
    ...    Send Request
    ...
    ...    ``session`` and ``headers`` 
    ...
    ...    ``method`` HTTP method(EX: Get, Post...)
    ...

    ${method}    Convert To Uppercase    ${method}

    ${log_message}    Run Keyword If    '${method}' == 'GET' and $kwargs    Set Variable    ${method} ${uri}, params=${kwargs}
    ...    ELSE IF    '${method}' == 'GET' and not $kwargs    Set Variable    ${method} ${uri}
    ...    ELSE    Set Variable    ${method} ${uri}, payload=${kwargs}

    Log    ${log_message}    html=True    console=True

    ${response}    Run Keyword If    '${method}' == 'POST'
    ...    Post Request    ${session}    ${uri}    data=${kwargs}    timeout=${timeout}    headers=${headers}
    ...    ELSE IF    '${method}' == 'GET' and $kwargs
    ...    Get Request    ${session}    ${uri}    params=${kwargs}    timeout=${timeout}    headers=${headers}
    ...    ELSE IF    '${method}' == 'GET' and not $kwargs
    ...    Get Request    ${session}    ${uri}    timeout=${timeout}    headers=${headers}
    ...    ELSE IF    '${method}' == 'PUT'
    ...    Put Request    ${session}    ${uri}    data=${kwargs}    timeout=${timeout}    headers=${headers}
    ...    ELSE IF    '${method}' == 'DELETE'
    ...    Delete Request    ${session}    ${uri}    data=${kwargs}    timeout=${timeout}    headers=${headers}

    [Return]    ${response}


Wait Element And Input
    [Arguments]     ${locator}    ${text}    ${wait_time}=15s
    [Documentation]
    ...
    ...   Wait for element and Input the text(value)
    ...

    Run Keyword If    type($locator) is str     AppiumLibrary.Wait Until Page Contains Element    ${locator}    ${wait_time}
    AppiumLibrary.Input Text    ${locator}    ${text}


Wait Element And Click Element
    [Arguments]     ${locator}    ${wait_time}=15s
    [Documentation]
    ...
    ...   Wait for element and Click() the locator
    ...

    Run Keyword If    type($locator) is str     AppiumLibrary.Wait Until Page Contains Element    ${locator}    ${wait_time}
    AppiumLibrary.Click Element    ${locator}
   

Wait Element And Get Text

    [Arguments]
    ...    ${locator}    ${wait_time}=15s

    Run Keyword If    type($locator) is str     AppiumLibrary.Wait Until Page Contains Element    ${locator}    ${wait_time}
    ${text}    AppiumLibrary.Get Text    ${locator}

    [Return]    ${text}


Get Text And Compare
    [Arguments]    ${locator}    ${text}
    [Documentation]
    ...
    ...   To check the value of element locator is the same
    ...

    AppiumLibrary.Wait Until Element Is Visible    ${locator}
    AppiumLibrary.Element Text Should Be    ${locator}    ${text}

Get Text And Contain
    [Arguments]    ${locator}    ${text}
    [Documentation]
    ...
    ...   To check the value of element locator is the same
    ...

    AppiumLibrary.Wait Until Element Is Visible    ${locator}
    AppiumLibrary.Element Should Contain Text    ${locator}    ${text}

Get Text And Not Equal
    [Arguments]    ${locator}    ${text}
    [Documentation]
    ...
    ...   To check the value of element locator is NOT the same
    ...

    AppiumLibrary.Wait Until Element Is Visible    ${locator}
    AppiumLibrary.Element Should Not Contain Text    ${locator}    ${text}

Close Keyboard
    [Documentation]
    ...
    ...   Hide the device   Keyboard 
    ...

    ${is_keyboard_shown}    Is Keyboard Shown
    Run Keyword If    ${is_keyboard_shown}    Hide Keyboard

