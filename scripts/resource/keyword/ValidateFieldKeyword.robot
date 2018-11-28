*** Settings ***

Library    Selenium2Library
Resource    ../repository/ValidateFieldRepo.robot


*** Keywords ***

Open FeedReader With Chrome Browser
    Open Browser    http://localhost:4200/main    chrome
    Set Selenium Speed    0.5
    Wait Until Element Is Visible    ${settingModalButton}    ${timetoWait}

Open Setting Modal
    Click Element    ${settingModalButton}
    Wait Until Element Is Visible    ${titleInputField}    ${timetoWait}

Valid Title Field With No URL
    Input Text    ${titleInputField}    RobotTestTitle
    Element Should Be Disabled    ${saveButton}
    Clear Input Text Method    ${titleInputField}    ${urlInputField}

Valid URL Field With No Title
    Input Text    ${urlInputField}    RobotTestURL
    Element Should Be Disabled    ${saveButton}
    Clear Input Text Method    ${titleInputField}    ${urlInputField}

Valid Title Field With URL
    Input Text    ${titleInputField}    RobotTestTitle
    Input Text    ${urlInputField}    RobotTestURL
    Element Should Be Enabled    ${saveButton}
    Clear Input Text Method    ${titleInputField}    ${urlInputField}
    
Invalid Title Field Thai Language
    Input Text    ${titleInputField}    ภาษาไทย
    Click Element    ${urlInputField}
    Element Should Be Visible    ${errorTitleXpath}
    ${errorToCheck}    Get Text    ${errorTitleXpath}
    Should Be Equal As Strings    ${errorToCheck}    ${errorTitleWord}
    Element Should Be Disabled    ${saveButton}
    Clear Input Text Method    ${titleInputField}    ${urlInputField}

URL Field Thai Language 
    Input Text    ${urlInputField}    ภาษาไทย
    Element Should Be Disabled    ${saveButton}
    Clear Input Text Method    ${titleInputField}    ${urlInputField}

URL Field Thai Language With Valid Title
    Input Text    ${urlInputField}    ภาษาไทย
    Input Text    ${titleInputField}    RobotTitle
    Element Should Be Enabled    ${saveButton}
    Clear Input Text Method    ${titleInputField}    ${urlInputField}

URL Field With Empty
    Click Element    ${urlInputField}
    Click Element    ${tableHeaderXpath}
    Element Should Be Visible    ${errorURLXpath}
    ${errorToCheck}    Get Text    ${errorURLXpath}
    Should Be Equal As Strings    ${errorToCheck}    ${errorURLWord}
    Element Should Be Disabled    ${saveButton}
    
Clear Input Text Method
    [Arguments]    ${titleInputField}    ${urlInputField}
    Clear Element Text    ${titleInputField}
    Clear Element Text    ${urlInputField}
