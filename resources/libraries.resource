*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    DebugLibrary
Library    String
Library    DateTime
Library    DatabaseLibrary
Library    FakerLibrary    locale=zh_TW
Library    AppiumLibrary    run_on_failure=AppiumLibrary.CapturePageScreenshot
Library    Process
Library    utility${/}get_ip_and_free_port.py
Library    OperatingSystem
Library    yaml
Library    BuiltIn
Library    Dialogs
Library    JSONLibrary
Library    OCRLibrary