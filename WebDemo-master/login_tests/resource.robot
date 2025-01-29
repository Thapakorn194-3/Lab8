*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    D://2-2567//chrome-win64//chrome.exe
${CHROME_DRIVER_PATH}     D://2-2567//chromedriver-win64//chromedriver.exe
${SERVER}                 localhost:7272
${BROWSER}                Chrome
${DELAY}                  0
${VALID USER}             demo
${VALID PASSWORD}         mode
${LOGIN URL}              http://${server}/
${WELCOME URL}            http://${server}/welcome.html
${ERROR URL}              http://${server}/error.html

*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Open Browser To Login Page
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${chrome_options.binary_location}     Set Variable    ${CHROME_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}") 
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${LOGIN URL}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page