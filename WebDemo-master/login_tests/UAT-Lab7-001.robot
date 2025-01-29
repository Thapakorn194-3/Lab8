*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    D://2-2567//chrome-win64//chrome.exe
${CHROME_DRIVER_PATH}     D://2-2567//chromedriver-win64//chromedriver.exe
${SERVER}                 localhost:7272
${BROWSER}                Chrome
${Form}                  http://${SERVER}/Form.html
${Complete}              http://${SERVER}/Complete.html
${DELAY}                 0  

*** Keywords ***
Open Browser To Page
    [Arguments]    ${url}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}") 
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${url}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

*** Test Cases ***
Test Form Submission with Valid Data
    [Documentation]    กรอกข้อมูลครบถ้วน 
    Open Browser To Page    ${Form}
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email          somsong@kkumail.com
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Close Browser
    Open Browser To Page    ${Complete}
    Close Browser
