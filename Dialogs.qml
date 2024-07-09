import QtQuick
import QtCore
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import "Desktop_Calendar.js" as Controller

Item {
    property alias about: _about
    property alias addScheduleDialog:_addScheduleDialog
    property alias modifyScheduleDialog:_modifyScheduleDialog
    property alias popup:_popup
    property alias eventCountdown: _eventCountdown
    property alias eventMessageInput: _eventMessageInput
    property alias failToSave: _failToSave
    property alias failToOpen: _failToOpen
    property alias noschedule: _noSchedule
    property alias failTime:_failTime
    property alias failMessage:_failMessage
    property alias fileSave: _fileSave
    property alias modifyMessageDialog:_modifyMessageDialog
    property alias deleteScheduleDialog:_deleteScheduleDialog
    property alias pop: _pop
    property alias fileOpen: _fileOpen

    CustomDesktopTip {
           id: _pop
           title: qsTr("Schedule")
           content:Rectangle {
               id: _rect
               width: 300
               height: 200
               color: "green"
               property alias eventText: _event.text
               property alias timeText: _time.text
               ColumnLayout {
                    anchors.centerIn: parent
                    Text {
                    id:_event
                    text: "" // 显示事件名称
                    font.bold: true
                    font.pointSize: 16
                    wrapMode: Text.WordWrap
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    id:_time
                    text: "" // 显示事件时间范围
                    wrapMode: Text.WordWrap
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
              }
           }
           function updateText(eventText, timeText) {
             content_loader.item.eventText= eventText;
             content_loader.item.timeText = timeText;
           }
       }

    Timer {
           id: scheduleTimer
           interval: 1000
           running: true
           repeat: true
           onTriggered: {
               var now = new Date();
               // 遍历日程数据，查找匹配当前时间的日程
               var Schedules=content.fileManager.getAllSchedulesAsVariantList()
               for (var i = 0; i < Schedules.length; ++i) {
                   var schedule = Schedules[i];
                   var scheduleTime = new Date(schedule.eventDate+'T'+schedule.reminderTime);
                   // 设置一个时间窗口，比如前后各1s
                   var windowStart = new Date(scheduleTime.getTime() - 1 * 1000);
                   var windowEnd = new Date(scheduleTime.getTime() + 1 * 1000);

                   // 检查当前时间是否在时间窗口内
                   if (now >= windowStart && now <= windowEnd) {
                       _pop.updateText("Schedule:"+schedule.eventName, "Satrt time：" + schedule.startTime + " to " + schedule.endTime);
                       _pop.showTip(); // 显示对话框
                       content.fileManager.deleteFile(content.fileManager.generateFileName(schedule.eventDate,schedule.startTime));
                       Controller.update()
                       break; // 找到匹配的日程后停止继续检查
                   }
               }
           }
       }

    //添加事件
    Dialog {
        id: _addScheduleDialog
        title: "Add Event"
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal:true
        anchors.centerIn: parent
        width:parent.width
        height:parent.height
        opacity: 0.8 // 设置透明度为 80%


    TextField {
        id: _eventMessageInput
        placeholderText: "Enter event message..."
        width: parent.width - 20
        anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
        anchors.topMargin: 20
    }

    Text {
        id: start_text
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: _eventMessageInput.bottom
        anchors.topMargin: 10
        text: "start  : "
        color:"white"
    }

    TimePicker {
       id:start_timePicker
      anchors.left: start_text.right
      anchors.top:_eventMessageInput.bottom
       anchors.topMargin: 8
    }

    Text {
        id: end_text
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: start_text.bottom
        anchors.topMargin: 30
        text: "end   : "
        color:"white"
    }

    TimePicker {
        id:end_timePicker
        anchors.left: end_text.right
        anchors.top:start_text.bottom
        anchors.topMargin: 30
    }

    Text {
        id:remind_text
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: end_text.bottom
        anchors.topMargin: 30
        text: "remind(before start) : "
        color:"white"
    }

    TimePicker {
        id:remind_timePicker

        anchors.left: end_text.right
        anchors.top:remind_text.bottom
        anchors.topMargin: 10
    }

        // 处理 OK 按钮的点击事件
        onAccepted: {
            //判断选择日期是否正确
            if(content.fileManager.isValidDate(content.calendar.control.selectDate)){
                //消息存储
                Controller.storage()
                Controller.destruction()
                eventMessageInput.text=""
                Controller.update()
            }else{
                content.dialogs.failToSave.open()
                Controller.destruction()
                eventMessageInput.text=""
            }
        }
        onRejected: {
            // 处理 Cancel 按钮的点击事件
            Controller.destruction()
            eventMessageInput.text=""
        }
}

    //修改事件
    Dialog{
        id: _modifyScheduleDialog
        standardButtons: Dialog.Ok | Dialog.Cancel
        title: "Modify Event"
        modal:true
        anchors.centerIn: parent
        width:parent.width
        height:parent.height
        opacity: 0.8 // 设置透明度为 80%

        onVisibleChanged: {
               if (!visible) {
                  // 重新启用主窗口
                   content.calendar.enabled = true
               }
        }

        ScrollView {
            anchors.fill: parent
            Column {
                spacing: 10
                Repeater {
                    model: content.fileManager.getSchedulesAsVariantList(content.calendar.control.selectDate)
                    delegate: Column {
                        Button{                                                                                
                        Text {
                            text: "Schedule: " + modelData.eventName
                            font.pixelSize: 16
                            color: "white"
                          }

                        onClicked: {
                            console.log("clicked")
                            content.dialogs.modifyMessageDialog.startTime=modelData.startTime
                            if(content.fileManager.hasSchedule(content.calendar.control.selectDate)){
                                console.log(content.fileManager.getString(modelData.startTime))
                                content.dialogs.modifyMessageDialog.open()
                                content.dialogs.modifyMessageDialog.modifyeventMessageInput.placeholderText=modelData.eventName

                                content.calendar.enabled = false // 暂时禁用主窗口

                            }else{
                                content.dialogs.noschedule.open()
                            }
                         }
                        }

                        Text {
                            id:  _startTimeText
                            text: "Start Time: " + modelData.startTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "End Time: " + modelData.endTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "Reminder Time: " + modelData.reminderTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                    }
                }
            }
        }
    }

    //修改信息
    Dialog{
        property var startTime
        property alias modifyeventMessageInput: _modifyeventMessageInput
        id: _modifyMessageDialog
        title: "Modify Message"
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal:true
        anchors.centerIn: parent
        width:parent.width
        height:parent.height


        TextField {
            id: _modifyeventMessageInput
            width: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
        }

        Text {
            id: start_text2
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: _modifyeventMessageInput.bottom
            anchors.topMargin: 10
            text: "start  : "
            color:"white"
        }

        TimePicker {
           id:start_timePicker2
           anchors.left: start_text2.right
           anchors.top:_modifyeventMessageInput.bottom
           anchors.topMargin: 8
        }

        Text {
            id: end_text2
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: start_text2.bottom
            anchors.topMargin: 30
            text: "end   : "
            color:"white"
        }

        TimePicker {
            id:end_timePicker2
            anchors.left: end_text2.right
            anchors.top:start_text2.bottom
            anchors.topMargin: 30
        }

        Text {
            id:remind_text2
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: end_text2.bottom
            anchors.topMargin: 30
            text: "remind(before start) : "
            color:"white"
        }

        TimePicker {
            id:remind_timePicker2
            anchors.left: end_text2.right
            anchors.top:remind_text2.bottom
            anchors.topMargin: 10
        }

        // 处理 OK 按钮的点击事件
        onAccepted: {
            //判断选择日期是否正确
            if(content.fileManager.isValidDate(content.calendar.control.selectDate)){
                console.log("1")
                //消息存储
                if(Controller.storage2()){
                content.fileManager.deleteFile(content.fileManager.generateFileName(content.calendar.control.selectDate,startTime))
                Controller.destruction2()
                Controller.update()
                 modifyeventMessageInput.text=""
                }
            }else{
                content.dialogs.failToSave.open()
                modifyeventMessageInput.text=""
            }
        }
        onRejected: {
            // 处理 Cancel 按钮的点击事件
            Controller.destruction2()
            modifyeventMessageInput.text=""
        }

      }

    //删除事件
    Dialog{
        id: _deleteScheduleDialog
        standardButtons: Dialog.Ok | Dialog.Cancel
        title: "Delete Event"
        modal:true
        anchors.centerIn: parent
        width:parent.width
        height:parent.height
        opacity: 0.8 // 设置透明度为 80%

        onVisibleChanged: {
               if (!visible) {
                  // 重新启用主窗口
                   content.calendar.enabled = true
               }
        }

        ScrollView {
            property alias dayScheduleColumn: _dayScheduleColumn2
            id:_dayScheduleScrollView2
            anchors.fill: parent

            Column {
                property alias dayScheduleRepeater: _dayScheduleRepeater2

                id: _dayScheduleColumn2
                spacing: 10

               Repeater {
                    id:_dayScheduleRepeater2
                    model: content.fileManager.getSchedulesAsVariantList(content.calendar.control.selectDate)
                    delegate: Column {
                        Button{
                            id:_deleteButton
                        Text {
                            text: "Schedule: " + modelData.eventName
                            font.pixelSize: 16
                            color: "white"
                          }
                        onClicked: {
                            console.log("clicked")
                        _checkDialog.visible=true

                          }
                        }

                        Dialog {
                         property alias checkDialog: _checkDialog
                         implicitWidth: 300
                         id: _checkDialog
                         standardButtons: Dialog.Ok | Dialog.Cancel
                         title:"Check Box"
                         visible: false // 初始时不可见
                         contentItem: Text {
                             text: "Are you sure you want to delete this file?"
                             color: "white"
                             anchors.fill: parent
                             verticalAlignment: Text.AlignVCenter
                             horizontalAlignment: Text.AlignHCenter
                                             }
                              onAccepted: {
                              // 在这里处理文件删除的逻辑
                              var filePath = content.fileManager.generateFileName(content.calendar.control.selectDate,modelData.startTime); // 替换为你要删除的文件路径
                              var deleted = content.fileManager.deleteFile(filePath);
                                     if (deleted) {
                                     console.log("File deleted successfully:", filePath);
                                     Controller.update()
                                                  } else {
                                                             console.error("Failed to delete file:", filePath);
                                                             }
                                  checkDialog.visible = false; // 隐藏对话框
                                       }

                            onRejected: {
                              console.log("File deletion cancelled");
                              checkDialog.visible = false; // 隐藏对话框
                                       }
                                    }

                        Text {
                            text: "Start Time: " + modelData.startTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "End Time: " + modelData.endTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "Reminder Time: " + modelData.reminderTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                    }
                }
            }
        }

    }

    //所有日程信息查看
    Dialog {
        id: _eventCountdown
        title: qsTr("Event List")
        width: 250
        height: 300

        ScrollView {
            anchors.fill: parent
            clip: true

            Column {
                spacing: 10
                width: parent.width
                Repeater {
                    model: content.fileManager.getAllSchedulesAsVariantList()
                    delegate: Column {
                        spacing: 5
                        width: parent.width

                        Text {
                            text: "Schedule: " + modelData.eventName
                            font.pixelSize: 16
                            color: "white"
                        }

                        Text {
                            text: "Date:" + modelData.eventDate
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "Start Time:" + modelData.startTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "End Time: " + modelData.endTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }

                        Text {
                            text: "Reminder Time: " + modelData.reminderTime
                            font.pixelSize: 12
                            color: "lightgrey"
                        }
                    }
                }
            }
        }
    }

    //单个日程信息查看
    Popup {
        id: _popup
        width: Math.min(window.width * 0.6, 600)
        height: width
        modal: false
        visible: false
        opacity: 0.8
        anchors.centerIn: parent

        contentItem: Rectangle {
            anchors.fill: parent
            color: "black"
            border.width: 2
            border.color: "white"

            ScrollView {
                anchors.fill: parent


                Column {
                    id: scheduleColumn
                    spacing: 10

                    Repeater {
                        id: scheduleRepeater
                        model: content.fileManager.getSchedulesAsVariantList(content.calendar.control.selectDate)

                        delegate: Column {
                            Text {
                                text: "Schedule: " + modelData.eventName
                                font.pixelSize: 16
                                color: "white"
                            }


                            Text {
                                text: "Start Time: " + modelData.startTime
                                font.pixelSize: 12
                                color: "lightgrey"
                            }

                            Text {
                                text: "End Time: " + modelData.endTime
                                font.pixelSize: 12
                                color: "lightgrey"
                            }

                            Text {
                                text: "Reminder Time: " + modelData.reminderTime
                                font.pixelSize: 12
                                color: "lightgrey"
                            }
                        }
                    }
                }
            }
        }
    }

    //关于
    MessageDialog {
        id:_about
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Desktop_Calendar is Desktop memo"
        informativeText: qsTr("      Desktop memo is a free software that allows you to set a schedule and remind you of your own schedule.It also supports multiple people sharing and modifying the same memo.")
    }

    //判断存储时开始时间<结束时间的错误提示
    MessageDialog {
        id:_failTime
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save"
        informativeText: qsTr("Sorry, start time must be before end time.")
    }

    //当选择存储是日程信息为空的错误提示
    MessageDialog{
        id:_failMessage
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save"
        informativeText: qsTr("Sorry, message is null.")
    }

    //设定的时间在大于等于当天
    MessageDialog{
        id:_failToSave
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save"
        informativeText: qsTr("Sorry, the date you selected should be after today. Please choose a new date")
    }

    MessageDialog{
        id:_failToOpen
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to open"
        informativeText: qsTr("Sorry, you didn't open the file correctly")
    }

    //提示选定时间没有日程
    MessageDialog{
        id:_noSchedule
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"No schedule"
        informativeText: qsTr("Sorry, the date you have selected does not currently have a schedule")
    }

    //便签存储
    FileDialog {
        id: _fileSave
        title: "Select some text files"
        modality: Qt.ApplicationModal
        currentFolder: StandardPaths.writableLocation
                       (StandardPaths.DocumentsLocation)
        fileMode: FileDialog.SaveFile
        nameFilters: [ "Text files (*.txt *)" ]
    }

    FileDialog {
        id: _fileOpen
        title: "Select some text files"
        currentFolder: StandardPaths.standardLocations
                       (StandardPaths.DocumentsLocation)[0]
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "Text files (*.txt *)" ]
    }

}


