const { app, BrowserWindow, Menu,ipcMain } = require('electron');
let mainWindow;
let expressPort;

const express = require('express');
const appExpress = express();

function getAvailablePort() {
const net = require('net');
const server = net.createServer();
server.listen(0, () => {
expressPort = server.address().port;
server.close();
startExpress();
});
}

function startExpress() {
appExpress.use(express.static(__dirname + '/../renderer'));
appExpress.listen(expressPort, () => {
console.log('Express listening on port ' + expressPort);
createWindow();
});
}

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false, // Add this
      enableRemoteModule: true, // Add this,
      webSecurity: false // Add this
    },
    icon: 'https://smthubakgale.github.io/ChinaCentre/logo.png'
  });

  // Remove default menu bar
  Menu.setApplicationMenu(null);

  mainWindow.loadURL('https://smthubakgale.github.io/ChinaCentre-Desktop/');
  mainWindow.on('closed', function () {
    mainWindow = null;
  });
  
  mainWindow.webContents.on('did-finish-load', () => 
  {
	  mainWindow.webContents.executeJavaScript(`
	  window.addEventListener('message', (event) => {
		if (event.data === 'print-init') {
		  const printButton = document.getElementById('print-button');
		  printButton.addEventListener('click', () => {
			window.api.send('print-request');
		  });
		}
	  });
	`);

    mainWindow.webContents.send('print-init');
  });

  ipcMain.on('print-request', (event) => {
    mainWindow.webContents.print({ silent: true, printBackground: true }, (success, failureReason) => {
      if (!success) console.error(failureReason);
    });
  });

}

app.on('ready', getAvailablePort);

app.on('window-all-closed', function () {
if (process.platform !== 'darwin') {
app.quit();
}
});

app.on('activate', function () {
if (mainWindow === null) {
createWindow();
}
});