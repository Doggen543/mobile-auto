# Migo Automaiton - Version 2.3.0 
This project is build for Migo android mobile Automaiton test(develop base on 400854b89)

#
# Installation (Mac)
## 1.Homebrew 

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
```

```bash
brew install node
```
(*If upgrade needed)

```bash
brew upgrade node  
```
```bash
xcode-select –install
```
(*If upgrade needed)
```bash
softwareupdate –list  
```
## 2.Open JDK 
```bash
brew tap AdoptOpenJDK/openjdk
```
```bash
brew install --cask adoptopenjdk14
```
## 3.Android Studio
Download link as below, setup, download Android SDK
https://developer.android.com/studio/index.html#downloads

## 4.Set JAVA_HOME and ANDROID_HOME 
```bash
vim ~/.bash_profile
```
Set the path as example below, remeber to replace ${Username} to your name
```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home 
export PATH=$JAVA_HOME/bin:$PATH 
export ANDROID_HOME=/Users/${Username}/Library/Android/sdk 
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```
```bash
source ~/.bash_profile
```
The source command line can be used to load any functions file into the current shell script or a command prompt. If adb command line is like “zsh: command not found: adb” or the Appium is not work, you could use this source command.
## 5.Appium Server 
```bash
npm install -g Appium
```
## 6.Appium Client 

```bash
pip3 install Appium-Python-Client
```
*If upgrade needed
```bash
pip3 install --upgrade pip
```
## 7.Appium Desktop
Download from https://github.com/appium/appium-desktop/releases/tag/v1.15.1
## 8.Check all setting by Appium Doctor
```bash
npm install appium-doctor -g
```
```bash
appium-doctor –android
```
*If using Appium app to run Android apk on emulator, getting server error, try
appium -a 127.0.0.1 -p 4723 --session-override
## 9.Install robot framework
Please put the code under requirements.txt file first

[Reference](https://learn.markteaching.com/python-pip/)
```bash
robotframework==4.1.3
robotframework-appiumlibrary
robotframework-databaselibrary==1.2.4
robotframework-debuglibrary==2.2.2
robotframework-faker==5.0.0
robotframework-httplibrary==0.4.2
robotframework-jsonlibrary==0.3.1
robotframework-metrics==3.3.3
robotframework-ocrlibrary==2.0.0
robotframework-pythonlibcore==3.0.0
robotframework-requests==0.9.2
robotframework-selenium2library
robotframework-seleniumlibrary
robotframework-sshlibrary==3.8.0
robotframework-stacktrace==0.4.1
```
After that, you could exe. the command line below
```bash
pip3 install -r requirements.txt
```
## 10. Install Selenium
```bash
pip3 install selenium
```
## 11. Download chrome driver
https://chromedriver.chromium.org/downloads

Put chromedriver under usr/local/bin (mac)

[Reference](https://brettlin-78528.medium.com/%E7%94%A8-python-%E5%8C%AF%E5%85%A5-selenium-%E7%9A%84%E6%96%B9%E5%BC%8F-%E4%BB%A5%E5%8F%8A%E5%A6%82%E4%BD%95%E7%94%A8mac-%E5%AE%89%E8%A3%9D-chromedriver-5d92121c02d7)

# Robot Execution

## 1.Execute robot code
For Mac
```bash
python3 -m robot APP/cases/Migo_E2E_Test.robot 
```
For Window
```bash
robot APP/cases/Migo_E2E_Test.robot 
```
 (APP/cases/Migo_E2E_Test.robot is the path of current dir.)
## 1-1.Execute robot code with specific tag
For Mac
```bash
python3 -m robot –i e2e APP/cases/Migo_E2E_Test.robot 
```
For Window
```bash
robot –i e2e APP/cases/Migo_E2E_Test.robot 
```
[Official Document](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#toc-entry-223)

## 2.Generate robot report
```bash
robotmetrics 
```
[Robot Framework Metrics Report](https://github.com/adiralashiva8/robotframework-metrics)

## 3.Run the code in one command line (If needed)
For Mac
```bash
sh MigoE2E.sh 
```
For Windows you need to use .bat file
