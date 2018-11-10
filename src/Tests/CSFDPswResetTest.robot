*** Settings ***
Library  Selenium2Library
Resource  ../Keywords/BrowserKeywords.robot
Resource  ../Settings/LoginSettings.robot
Resource  ../Objects/CSFDObjects.robot
Resource  ../Keywords/CSFDCommon.robot

Test Setup  Open Browser And Maximize Window  ${browser}   ${url}
Test Teardown   Capture Screenshot And Close Browser

*** Test Cases ***

Reset password wrong email format test
    Open CSFD Nav Item  ${resetPswNav}  ${resetPswUrl}
    Insert Into Text Item Field     ${resetEmailInput}   ${non_existing_nickname}
    Click Button    ${resetEmailBtn}
    Alert Should Be Present     text=${incorrect_email_msg}

Reset password with non existing nickname fail test
    Open CSFD Nav Item  ${resetPswNav}  ${resetPswUrl}
    Insert Into Text Item Field     ${resetNicknameInput}   ${non_existing_nickname}
    Click Button    ${resetNicknameBtn}
    Verify Message Element Is On Page    ${reset_error_msg_id}

Reset password with success email test
    Open CSFD Nav Item  ${resetPswNav}  ${resetPswUrl}
    Insert Into Text Item Field     ${resetEmailInput}   ${existing_email}
    Click Button    ${resetEmailBtn}
    Verify Message Element Is On Page    ${success_reset}

Register Exists Nickname
      Open CSFD Nav Item    ${registerNav}    ${registerUrl}
      Insert Into Text Item Field    ${registerNicknameInput}    ${usr_nickname}
      Insert Into Text Item Field    ${registerEmailInput}    ${non-existing_email}
      AgreeAndClick    ${registerTandC}    ${registerNext}
      Execute Javascript    window.scrollTo(0,200);
      AgreeAndClick    ${registerGDPR}    ${registerFinish}   
      Verify Message Element Is On Page    ${registerMsg} 
      Wait Until Page Contains    ${registerMsgNickname}  


Register Exists Email
      Open CSFD Nav Item    ${registerNav}    ${registerUrl}
      Insert Into Text Item Field    ${registerNicknameInput}    ${non_existing_nickname}
      Insert Into Text Item Field    ${registerEmailInput}    ${usr_email}
      AgreeAndClick    ${registerTandC}    ${registerNext}
      Execute Javascript    window.scrollTo(0,200);
      AgreeAndClick    ${registerGDPR}    ${registerFinish}      
      Verify Message Element Is On Page    ${registerMsg} 
      Wait Until Page Contains    ${registerMsgEmail} 

Register Non Valid Date Of Birth
      Open CSFD Nav Item    ${registerNav}    ${registerUrl}
      Insert Into Text Item Field    ${registerNicknameInput}    ${non_existing_nickname}
      Insert Into Text Item Field    ${registerEmailInput}    ${non-existing_email}
      Insert Into Text Item Field    ${registerBirthInput}    ${incorect_birth_date}
      AgreeAndClick    ${registerTandC}    ${registerNext}
      Execute Javascript    window.scrollTo(0,200);
      AgreeAndClick    ${registerGDPR}    ${registerFinish}     
      Verify Message Element Is On Page    ${registerMsg} 
      Wait Until Page Contains    ${registerMsgBirth}    
    