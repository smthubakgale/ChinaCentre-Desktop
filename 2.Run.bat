@echo off

:: Set PATH to include Node.js
set PATH=%PATH%;C:\Program Files\nodejs

:: Navigate to project directory
cd ChinaCentre-Desktop

:: Run Electron project
START /WAIT /B cmd /c npx electron . --icon=logo.ico

pause 