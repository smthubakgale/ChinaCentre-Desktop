@echo off

:: Set PATH to include Node.js
set PATH=%PATH%;C:\Program Files\nodejs;C:\Program Files (x86)\Inno Setup 6;

:: Set project name
set projectName=ChinaCentre-Desktop

:: Set Electron version
set electronVersion=14.2.9

:: Set platform architecture
set arch=x64

:: Set output directory
set outputDir=dist

:: Create output directory
cd %projectName%
mkdir %outputDir%

:: Package for Windows
echo Packaging for Windows...
:: START /WAIT /B cmd /c npx electron-builder --win --x64 --ia32 --config.electronVersion=%electronVersion% 

 
START /WAIT /B cmd /c  npx electron-packager . --out=release-builds --arch=x64 --platform=win32  --icon=logo.ico --overwrite
START /WAIT /B cmd /c iscc Setup.iss

::pause 

:: Package for Linux
echo Packaging for Linux...
::START /WAIT /B cmd /c npx electron-builder --linux --x64 --ia32 --config.electronVersion=%electronVersion%

::START /WAIT /B cmd /c npx electron-packager . --out=release-builds --arch=x64 --platform=linux

:: Package for macOS (requires wine or a macOS machine)
echo Packaging for macOS...
:: npx electron-builder --mac --x64 --ia32 --config.electronVersion=%electronVersion%

::START /WAIT /B cmd /c npx electron-packager . --out=release-builds --arch=x64 --platform=darwin --osx-sign --identity="Developer ID Application: smthubakgale@gmail.com"

:: Move packaged files to output directory
move /y %projectName%-win32-x64\* %outputDir%\Windows\
move /y %projectName%-win32-ia32\* %outputDir%\Windows\
move /y %projectName%-linux-x64\* %outputDir%\Linux\
move /y %projectName%-linux-ia32\* %outputDir%\Linux\
:: move /y %projectName%-mac\* %outputDir%\macOS\

echo Packaging complete!

pause 