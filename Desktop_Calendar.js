function showPopup(date) {
    dialogs.popup.visible = true;
    // Center the popup relative to the main window
    dialogs.popup.x = (month_grid.width - dialogs.popup.width) / 2;
    dialogs.popup.y = (month_grid.height - dialogs.popup.height) / 2;
    console.log('Double-clicked date:',date);
}

function updateDateTime() {
    var currentTime = new Date()
    window.title = currentTime.toLocaleString(Qt.locale("de_DE"),"yyyy-MM-dd hh:mm:ss")
}


function open_addEventDialog() {
     content.dialogs.addEventDialog.open()
     content.calendar.enabled = false  // 暂时禁用主窗口

}
