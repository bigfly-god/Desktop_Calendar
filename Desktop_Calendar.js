function showPopup(date) {
    if(content.fileManager.hasSchedule(content.calendar.control.selectDate)){
        content.dialogs.popup.visible = true;
        // Center the popup relative to the main window
        content.dialogs.popup.x = (month_grid.width - dialogs.popup.width) / 2;
        content.dialogs.popup.y = (month_grid.height - dialogs.popup.height) / 2;
        console.log('Double-clicked date:',date);
    }else{
        content.dialogs.noschedule.open()
    }


}

function updateDateTime() {
    var currentTime = new Date()
    window.title = currentTime.toLocaleString(Qt.locale("de_DE"),"yyyy-MM-dd hh:mm:ss")
}

function open_addScheduleDialog() {
     content.dialogs.addScheduleDialog.open()
     content.calendar.enabled = false  // 暂时禁用主窗口
}

//恢复
function destruction(){
    start_timePicker.hourComboBox.currentIndex=0
    start_timePicker.minuteComboBox.currentIndex=0
    start_timePicker.secondComboBox.currentIndex=0
    end_timePicker.hourComboBox.currentIndex=0
    end_timePicker.minuteComboBox.currentIndex=0
    end_timePicker.secondComboBox.currentIndex=0
    remind_timePicker.hourComboBox.currentIndex=0
    remind_timePicker.minuteComboBox.currentIndex=0
    remind_timePicker.secondComboBox.currentIndex=0
}

function startTime(){
    var selectedStartHour = start_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedStartMinute = start_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedStartSecond = start_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var startDate = new Date();
    startDate.setDate(content.calendar.control.selectDate.getDate())
    startDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    startDate.setHours(selectedStartHour);
    startDate.setMinutes(selectedStartMinute);
    startDate.setSeconds(selectedStartSecond);

    return startDate;
}

function endTime(){
    var selectedEndHour = end_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedEndMinute = end_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedEndSecond = end_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var endDate = new Date();
    endDate.setDate(content.calendar.control.selectDate.getDate())
    endDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    endDate.setHours(selectedEndHour);
    endDate.setMinutes(selectedEndMinute);
    endDate.setSeconds(selectedEndSecond);

    return endDate;
}

function remindTime(){
    var startDate=startTime()

    var selectedRemindHour = remind_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedRemindMinute = remind_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedRemindSecond = remind_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var remindDate = new Date();
    remindDate.setDate(content.calendar.control.selectDate.getDate())
    remindDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    remindDate.setHours(startDate.getHours()-selectedRemindHour);
    remindDate.setMinutes(startDate.getMinutes()-selectedRemindMinute);
    remindDate.setSeconds(startDate.getSeconds()-selectedRemindSecond);

    return remindDate;
}

//存储
function storage(){
    var startDate=startTime()
    var endDate=endTime()
    var remindDate = remindTime();
    content.fileManager.addOrUpdateSchedule(content.calendar.control.selectDate,startDate,content.fileManager.setSchedule(eventMessageInput.text,
                                                                                                                             startDate,
                                                                                                                     endDate,
                                                                                                                  remindDate))
    console.log("finish storage")
}


function createnote(){
    content.notewindow.visible=true;
}
function sreenshout(){
    screenShotCom.source = "Screenshot.qml";

}

function exitnote(){
    content.notewindow.visible=false;
}

