function showPopup(date) {
    content.dialogs.popup.visible = true;
    // Center the popup relative to the main window
    content.dialogs.popup.x = (month_grid.width - dialogs.popup.width) / 2;
    content.dialogs.popup.y = (month_grid.height - dialogs.popup.height) / 2;
    console.log('Double-clicked date:',date);
}

function updateDateTime() {
    var currentTime = new Date()
    window.title = currentTime.toLocaleString(Qt.locale("de_DE"),"yyyy-MM-dd hh:mm:ss")
}


function open_addScheduleDialog() {
     content.dialogs.addScheduleDialog.open()
     content.calendar.enabled = false  // 暂时禁用主窗口
}

function scheduleStartTime(){
    var selectedStartHour = start_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedStartMinute = start_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedStartSecond = start_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var startDate = new Date();
    startDate.setDate(content.calendar.control.selectDate.getDate())
    startDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    startDate.setHours(selectedStartHour);
    startDate.setMinutes(selectedStartMinute);
    startDate.setSeconds(selectedStartSecond);
    console.log("Start Time:", startDate);
}

function scheduleEndTime(){
    var selectedEndHour = end_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedEndMinute = end_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedEndSecond = end_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var endDate = new Date();
    endDate.setDate(content.calendar.control.selectDate.getDate())
    endDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    endDate.setHours(selectedEndHour);
    endDate.setMinutes(selectedEndMinute);
    endDate.setSeconds(selectedEndSecond);
    console.log("End Time:", endDate);
}

function scheduleRemindTime(){
    var selectedStartHour = start_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedStartMinute = start_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedStartSecond = start_timePicker.secondComboBox.currentIndex// 获取选中的秒数

    var selectedRemindHour = remind_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedRemindMinute = remind_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedRemindSecond = remind_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var remindDate = new Date();
    remindDate.setDate(content.calendar.control.selectDate.getDate())
    remindDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    remindDate.setHours(selectedStartHour-selectedRemindHour);
    remindDate.setMinutes(selectedStartMinute-selectedRemindMinute);
    remindDate.setSeconds(selectedStartSecond-selectedRemindSecond);
    console.log("Remind Time:", remindDate);
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

//存储
function storage(){
    var selectedStartHour = start_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedStartMinute = start_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedStartSecond = start_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var startDate = new Date();
    startDate.setDate(content.calendar.control.selectDate.getDate())
    startDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    startDate.setHours(selectedStartHour);
    startDate.setMinutes(selectedStartMinute);
    startDate.setSeconds(selectedStartSecond);

    var selectedEndHour = end_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedEndMinute = end_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedEndSecond = end_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var endDate = new Date();
    endDate.setDate(content.calendar.control.selectDate.getDate())
    endDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    endDate.setHours(selectedEndHour);
    endDate.setMinutes(selectedEndMinute);
    endDate.setSeconds(selectedEndSecond);


    var selectedRemindHour = remind_timePicker.hourComboBox.currentIndex// 获取选中的小时
    var selectedRemindMinute = remind_timePicker.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedRemindSecond = remind_timePicker.secondComboBox.currentIndex// 获取选中的秒数
    var remindDate = new Date();
    remindDate.setDate(content.calendar.control.selectDate.getDate())
    remindDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    remindDate.setHours(selectedStartHour-selectedRemindHour);
    remindDate.setMinutes(selectedStartMinute-selectedRemindMinute);
    remindDate.setSeconds(selectedStartSecond-selectedRemindSecond);

   content.fileManager.addOrUpdateSchedule(content.calendar.control.selectDate,content.fileManager.setSchedule(eventMessageInput.text,
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


