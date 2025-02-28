@echo off

pause 
exit 
:: Set PATH to include Node.js
set PATH=%PATH%;C:\Program Files\nodejs

:: Set project name
set projectName=ChinaCentre-Desktop

:: Create project folder
mkdir %projectName%
cd %projectName%

:: Initialize npm
START /WAIT /B cmd /c npm init -y

:: Install Electron
START /WAIT /B cmd /c npm install electron@^34.2.0 --save-dev

:: Install electron-builder
START /WAIT /B cmd /c npm install electron-builder@^25.1.8 --save-dev

:: Install Express
START /WAIT /B cmd /c npm install express@^4.21.2

:: Create basic Electron app structure
mkdir src

cd src 
mkdir main
mkdir renderer
mkdir assets 

:: Create main.js file

cd main 

echo. > main.js
echo const { app, BrowserWindow, Menu  } = require('electron'); >> main.js
echo let mainWindow; >> main.js
echo let expressPort; >> main.js
echo. >> main.js
echo const express = require('express'); >> main.js
echo const appExpress = express(); >> main.js
echo. >> main.js
echo function getAvailablePort() { >> main.js
echo   const net = require('net'); >> main.js
echo   const server = net.createServer(); >> main.js
echo   server.listen(0, () => { >> main.js
echo     expressPort = server.address().port; >> main.js
echo     server.close(); >> main.js
echo     startExpress(); >> main.js
echo   }); >> main.js
echo } >> main.js
echo. >> main.js
echo function startExpress() { >> main.js
echo   appExpress.use(express.static(__dirname + '/../renderer')); >> main.js
echo   appExpress.listen(expressPort, () => { >> main.js
echo     console.log('Express listening on port ' + expressPort); >> main.js
echo     createWindow(); >> main.js
echo   }); >> main.js
echo } >> main.js
echo. >> main.js
echo function createWindow() { >> main.js
echo   mainWindow = new BrowserWindow({ >> main.js
echo     width: 800, >> main.js
echo     height: 600, >> main.js
echo     webPreferences: { >> main.js
echo       nodeIntegration: true >> main.js
echo     }, >> main.js
echo     icon: 'https://smthubakgale.github.io/ChinaCentre/logo.png' >> main.js
echo   }); >> main.js
echo. >> main.js
echo   // Remove default menu bar >> main.js
echo   Menu.setApplicationMenu(null); >> main.js
echo. >> main.js
echo   mainWindow.loadURL('http://localhost:' + expressPort + '/index.html?port=' + expressPort); >> main.js
echo   mainWindow.on('closed', function () { >> main.js
echo     mainWindow = null; >> main.js
echo   }); >> main.js
echo } >> main.js
echo. >> main.js
echo app.on('ready', getAvailablePort); >> main.js
echo. >> main.js
echo app.on('window-all-closed', function () { >> main.js
echo   if (process.platform !== 'darwin') { >> main.js
echo     app.quit(); >> main.js
echo   } >> main.js
echo }); >> main.js
echo. >> main.js
echo app.on('activate', function () { >> main.js
echo   if (mainWindow === null) { >> main.js
echo     createWindow(); >> main.js
echo   } >> main.js
echo }); >> main.js

:: Create index.html file

cd ..
cd renderer

echo. > index.html
echo ^<!DOCTYPE html^> >> index.html
echo ^<html^> >> index.html
echo ^<head^> >> index.html
echo   ^<meta charset="UTF-8"^> >> index.html
echo   ^<title^>China Centre Desktop App^</title^> >> index.html
echo   ^<style^> >> index.html
echo     body { >> index.html
echo       margin: 0px; >> index.html
echo       padding: 0px; >> index.html
echo       overflow: hidden; /* Add this to prevent scrolling */ >> index.html
echo     } >> index.html
echo   ^</style^> >> index.html
echo ^</head^> >> index.html
echo ^<body^> >> index.html
echo   ^<script^> >> index.html
echo     const urlParams = new URLSearchParams(window.location.search); >> index.html
echo     const port = urlParams.get('port'); >> index.html
echo     console.log('Port:', port); >> index.html
echo   ^</script^> >> index.html
echo   ^<iframe src="https://smthubakgale.github.io/ChinaCentre-Desktop/" frameborder="0" style="width:100%; height:100vh; border:none;"^>^</iframe^> >> index.html
echo ^</body^> >> index.html
echo ^</html^> >> index.html

:: Update package.json

cd ..
cd ..

echo { > package.json
echo   "name": "%projectName%", >> package.json
echo   "version": "1.0.0", >> package.json
echo   "description": "Furniture Ecommerce Application", >> package.json
echo   "main": "src/main/main.js", >> package.json
echo   "scripts": { >> package.json
echo     "start": "electron --icon=./logo.ico ." >> package.json
echo   }, >> package.json
echo   "keywords": [], >> package.json
echo   "author": "TevrocSoft", >> package.json
echo   "license": "ISC", >> package.json
echo   "dependencies": { >> package.json
echo     "express": "^4.21.2" >> package.json
echo   }, >> package.json
echo   "build": { >> package.json
echo     "win": { >> package.json
echo       "icon": "logo.ico" >> package.json
echo     } >> package.json
echo   }, >> package.json
echo   "devDependencies": { >> package.json
echo     "electron": "^34.2.0", >> package.json
echo     "electron-builder": "^25.1.8" >> package.json
echo   } >> package.json
echo } >> package.json

echo Project created successfully!
echo Run "npm start" to start the app.
echo Run "npm run build" to build the app.

pause