const { app, BrowserWindow } = require('electron');
const appFolderName = "/turtle-actionCenter/";
const configFolder = app.getPath('appData') + appFolderName;
const tempFolder = app.getPath('temp') + appFolderName;
const { createWindow } = require(configFolder + 'index.js');
const { exec } = require("child_process");

app.whenReady().then(() => {
    const win = createWindow();
    const windowId = win.getMediaSourceId().split(':')[1];
    console.log('este es el handle de la ventana: ' + windowId);
    exec("mkdir " + tempFolder);
    exec("./turnToDock.sh " + windowId + " 500 full right &> /tmp/turtle-actionCenter/log.txt", (error, stdout, stderr) => {
        if (error) {
            console.log(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.log(`stderr: ${stderr}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
    });

});

const interval = setInterval(function() {
    const window = BrowserWindow.getAllWindows()[0];
}, 5000);
