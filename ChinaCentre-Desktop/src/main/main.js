const { app, BrowserWindow, Menu, session } = require('electron');
const htmlPdf = require('html-pdf');
const fs = require('fs');
const path = require('path');

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
      webSecurity: false , // Add this
      allowPopups: true,
	  nativeWindowOpen: true,
    },
    icon: 'https://smthubakgale.github.io/ChinaCentre/logo.png'
  });

  // Remove default menu bar
  Menu.setApplicationMenu(null);

  mainWindow.loadURL('https://smthubakgale.github.io/ChinaCentre-Desktop/');
  mainWindow.webContents.on('new-window', (event, url, frameName, disposition, options) => {
	  event.preventDefault();
	  const newWin = new BrowserWindow(options);
	  newWin.loadURL(url);
	});

  mainWindow.on('closed', function () {
    mainWindow = null;
  }); 

  session.defaultSession.on('will-download', (event, item, webContents) => {
	  item.on('done', (event, path) => {
		console.log(`File downloaded to: ${item.savePath}`);
		
		if(item.savePath.indexOf(".html") != -1) {
			const htmlPath = item.savePath;
			const pdfPath = item.savePath.replace(".html" , ".pdf");

			const html = fs.readFileSync(htmlPath, 'utf8');
			const options = {
			  format: 'A4',
			  orientation: 'portrait',
              timeout: 30000, // 30-second timeout
			};

			htmlPdf.create(html, options).toFile(pdfPath, (err) => {
			  if (err) {
				console.error(err);
			  }
			});
		}
		
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