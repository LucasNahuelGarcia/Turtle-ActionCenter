const {app, BrowserWindow} = require('electron');
const { exec } = require("child_process");


const createWindow = () => {
    const win = new BrowserWindow({
        title: 'LuquiDock',
        width: 1920,
        height: 600,
        frame: false,
        titleBarStyle: 'hidden',
        transparent: true,
        movable: true,
        center: true,
        kiosk: false,
        fullscreen: false,
        frame: false,
        minimizable: false,
        maximizable: false,
        closable: false,
    });
    win.setResizable(false);
    win.loadURL('https://www.accuweather.com/es/ar/buenos-aires/7894/weather-forecast/7894');
    // win.loadFile('index.html');
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
};

app.whenReady().then(() => {
    const ventanas = BrowserWindow.getAllWindows().length > 0;
    if (ventanas)
        app.quit();
    createWindow();
});
