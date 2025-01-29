*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    D://2-2567//chrome-win64//chrome.exe
${CHROME_DRIVER_PATH}     D://2-2567//chromedriver-win64//chromedriver.exe
${SERVER}                 localhost:7272
${BROWSER}                Chrome
${Form}    http://${SERVER}/Form.html
${Complete}    http://${SERVER}/Complete.html
${DELAY}                 0  

*** Keywords ***
Open Browser To Form Page
    [Arguments]    ${url}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${url}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

*** Test Cases ***
Validate Destination Field
    [Documentation]    กรอกข้อมูลไม่ครบถ้วน (ไม่มี destination )
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email          somsong@kkumail.com
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Element Text Should Be    id=errors    **Please enter your destination.**
    Close Browser

*** Test Cases ***
Validate Empty Email Field
    [Documentation]    กรอกข้อมูลไม่ครบถ้วน (ไม่มี email)
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother        
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Element Text Should Be    id=errors    **Please enter your email
    Close Browser

*** Test Cases ***
Validate Invalid Email Field
    [Documentation]    กรอกข้อมูลไม่ครบถ้วน (email ไม่ถูกต้อง)
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email          somsong
    Input Text         id=phone          081-111-1234
    Click Button       id=submitButton
    Element Text Should Be    id=errors    **Please enter a valid email
    Close Browser

*** Test Cases ***
Validate Empty Phone Field
    [Documentation]    กรอกข้อมูลไม่ครบถ้วน (ไม่ใส่ phone)
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email    somsong@kkumail.com                  
    Click Button       id=submitButton
    Element Text Should Be    id=errors    **Please enter your phone
    Close Browser

*** Test Cases ***
Validate Invalid Phone Field
    [Documentation]    กรอกข้อมูลไม่ครบถ้วน (phone ไม่ถูกต้อง)
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email    somsong@kkumail.com          
    Input Text         id=phone    000         
    Click Button       id=submitButton
    Element Text Should Be    id=errors    **Please enter your phone