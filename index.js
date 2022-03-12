const { app, BrowserWindow } = require('electron');
const configFolder = app.getPath('appData') + "/turtle-actionCenter/";
const { createWindow } = require(configFolder + 'index.js');
const { exec } = require("child_process");

app.whenReady().then(() => {
    const win = createWindow();
    const windowId = win.getMediaSourceId().split(':')[1];
    console.log('este es el handle de la ventana: ' + windowId);
    exec("./turnToDock.sh " + windowId + " 800 full right", (error, stdout, stderr) => {
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
