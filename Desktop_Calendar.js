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

function open_modifyScheduleDialog(){
    if(content.fileManager.hasSchedule(content.calendar.control.selectDate)){
    content.dialogs.modifyScheduleDialog.open()
    content.calendar.enabled = false // 暂时禁用主窗口
    }else{
        content.dialogs.noschedule.open()
    }
}

function open_deleteScheduleDialog(){
    if(content.fileManager.hasSchedule(content.calendar.control.selectDate)){
    content.dialogs.deleteScheduleDialog.open()
    content.calendar.enabled = false // 暂时禁用主窗口
    }else{
        content.dialogs.noschedule.open()
    }
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

function destruction2(){
    start_timePicker2.hourComboBox.currentIndex=0
    start_timePicker2.minuteComboBox.currentIndex=0
    start_timePicker2.secondComboBox.currentIndex=0
    end_timePicker2.hourComboBox.currentIndex=0
    end_timePicker2.minuteComboBox.currentIndex=0
    end_timePicker2.secondComboBox.currentIndex=0
    remind_timePicker2.hourComboBox.currentIndex=0
    remind_timePicker2.minuteComboBox.currentIndex=0
    remind_timePicker2.secondComboBox.currentIndex=0
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
function startTime2(){
    var selectedStartHour = start_timePicker2.hourComboBox.currentIndex// 获取选中的小时
    var selectedStartMinute = start_timePicker2.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedStartSecond = start_timePicker2.secondComboBox.currentIndex// 获取选中的秒数
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

function endTime2(){
    var selectedEndHour = end_timePicker2.hourComboBox.currentIndex// 获取选中的小时
    var selectedEndMinute = end_timePicker2.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedEndSecond = end_timePicker2.secondComboBox.currentIndex// 获取选中的秒数
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
function remindTime2(){
    var startDate=startTime()

    var selectedRemindHour = remind_timePicker2.hourComboBox.currentIndex// 获取选中的小时
    var selectedRemindMinute = remind_timePicker2.minuteComboBox.currentIndex // 获取选中的分钟
    var selectedRemindSecond = remind_timePicker2.secondComboBox.currentIndex// 获取选中的秒数
    var remindDate = new Date();
    remindDate.setDate(content.calendar.control.selectDate.getDate())
    remindDate.setMonth(content.calendar.control.selectDate.getMonth() + 1)
    remindDate.setHours(startDate.getHours()-selectedRemindHour);
    remindDate.setMinutes(startDate.getMinutes()-selectedRemindMinute);
    remindDate.setSeconds(startDate.getSeconds()-selectedRemindSecond);

    return remindDate;
}

//存储（add）
function storage(){
    var startDate=startTime()
    var endDate=endTime()
    var remindDate = remindTime();

    if(content.dialogs.eventMessageInput.text===""){
        content.dialogs.failMessage.open()
         console.log("fail to storage")
    }else if(startDate<endDate){
        content.fileManager.addOrUpdateSchedule(content.calendar.control.selectDate,startDate,content.fileManager.setSchedule
                                            (eventMessageInput.text,content.calendar.control.selectDate,startDate,endDate,remindDate))
         console.log("finish storage")
    }else{
        content.dialogs.failTime.open()
         console.log("fail to storage")
    }


}
//存储（modify）
function storage2(){
    var startDate=startTime2()
    var endDate=endTime2()
    var remindDate = remindTime2();

    if(content.dialogs.modifyMessageDialog.modifyeventMessageInput.text===""){
        content.dialogs.failMessage.open()
         console.log("fail to storage")
    }else if(startDate<endDate){
        content.fileManager.addOrUpdateSchedule(content.calendar.control.selectDate,startDate,content.fileManager.setSchedule
                                            (modifyMessageDialog.modifyeventMessageInput.text,content.calendar.control.selectDate,startDate,endDate,remindDate))

        console.log("finish storage")
        return true
    }else{
        content.dialogs.failTime.open()
         console.log("fail to storage")
    }
}


function createnote(){
    content.notewindow.visible=true;
}
function sreenshout(){
    screenShotCom.source = "Screenshot.qml";
    notewindow.visible=false

}

function exitnote(){
    content.notewindow.visible=false;
}

//刷新页面
function update(){
    content.calendar.month_grid.year+=1;
    content.calendar.month_grid.year-=1;

    content.calendar.control.selectDate.setDate( content.calendar.control.selectDate.getDate() + 1);
    content.calendar.control.selectDate.setDate( content.calendar.control.selectDate.getDate() - 1);


}

function getTimestamp() {
      var now = new Date();
      var year = now.getFullYear();
      var month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，所以需要+1并补0
      var day = String(now.getDate()).padStart(2, '0');
      var hours = String(now.getHours()).padStart(2, '0');
      var minutes = String(now.getMinutes()).padStart(2, '0');
      var seconds = String(now.getSeconds()).padStart(2, '0');
      var milliseconds = String(now.getMilliseconds()).padStart(3, '0');
      return year + '-' + month + '-' + day + '_' + hours + '-' + minutes + '-' + seconds + '-' + milliseconds;
  }


function captureScreenshot(fileName,x, y, width, height) {
    g_screenShot.saveImageToFile(fileName,x, y, width, height);
    console.log("selectionRect.x, selectionRect.y, selectionRect.width, selectionRect.height",selectionRect.x, selectionRect.y, selectionRect.width, selectionRect.height)

          }

function save(){

    let currentStates = contente1.currentState()
    let modified = currentStates[0]
    let titled = currentStates[1]
    console.log(modified, titled)

    if(titled && !modified){
        return //r1
    }else if(titled && modified){
        if(!content.textContent.saveFile())
            content.dialogs.failToSave.open()
        return  //r2,r3
    }
    content.dialogs.fileSave.rejected.
    connect(()=>{ return })//r4

    content.dialogs.fileSave.accepted.
    connect(()=>{
                //fileSaveAcceptedHandler
                let filepath = content.dialogs.fileSave.selectedFile
                console.log(filepath.toString())

                if(filepath.toString() !== "")
                if(!contente1.textContent.saveFile(filepath))
                content.dialogs.failToSave.open()
                return;} )//r5,r6

    content.dialogs.fileSave.open()
}

function open() {
    let currentStates = contente1.currentState();
    let modified = currentStates[0];
    let titled = currentStates[1];
    console.log(modified, titled);

    if (titled && !modified) {
        return; // 处理已命名但未修改的情况
    } else if (titled && modified) {
        if (!content.textContent.saveFile()) {
            content.dialogs.failToSave.open();
        }
        return; // 处理已命名且已修改的情况
    }

    // 连接拒绝信号
    content.dialogs.fileOpen.rejected.connect(() => {
        return; // 处理拒绝逻辑
    });

    // 连接接受信号
    content.dialogs.fileOpen.accepted.connect(() => {
        // fileOpenAcceptedHandler
        let filepath = content.dialogs.fileOpen.selectedFile;
        console.log(filepath.toString());

        if (filepath.toString() !== "") {
            if (!contente1.textContent.openFile(filepath)) {
                content.dialogs.failToOpen.open();
            }
        }
        return;
    });

    // 打开对话框
    content.dialogs.fileOpen.open();
}


function initial(){
    content.textContent.textDocument.modifiedChanged.
    connect(()=>{
                   let m = content.textContent.textDocument.modified
                   console.log("modified: ", m)
                   if(m){
                       window.title = content.textContent.title + "*"
                       console.log("window title1:", content.textContent.title, "*")
                   }else{
                       window.title = content.textContent.title
                       console.log("window title2:", content.textContent.title)
                   }
               })
}


function getStartTime(){
       var selectedStartHour = start_timePicker2.hourComboBox.currentIndex; // 获取选中的小时索引
       var selectedStartMinute = start_timePicker2.minuteComboBox.currentIndex; // 获取选中的分钟索引
       var selectedStartSecond = start_timePicker2.secondComboBox.currentIndex; // 获取选中的秒数索引

       // 根据选中的索引值获取对应的小时、分钟、秒数
       var hours = ("0" + selectedStartHour).slice(-2); // 将小时格式化为两位数
       var minutes = ("0" + selectedStartMinute).slice(-2); // 将分钟格式化为两位数
       var seconds = ("0" + selectedStartSecond).slice(-2); // 将秒数格式化为两位数

       return hours + ":" + minutes + ":" + seconds;
}



