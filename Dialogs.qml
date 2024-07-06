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
    property alias noschedule: _noSchedule
    property alias failTime:_failTime
    property alias failMessage:_failMessage
    property alias fileSave: _fileSave

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

    Dialog{
        id: _modifyScheduleDialog
        title: "Modify Event"
        modal:true
        anchors.centerIn: parent
        width:parent.width
        height:parent.height
        opacity: 0.8 // 设置透明度为 80%
    }
    
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
                                text: "Date:" + modelData.eventDate
                                font.pixelSize: 12
                                color: "lightgrey"
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

    MessageDialog {
        id:_about
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Desktop_Calendar is Desktop memo"
        informativeText: qsTr("      Desktop memo is a free software that allows you to set a schedule and remind you of your own schedule.It also supports multiple people sharing and modifying the same memo.")
    }

    MessageDialog {
        id:_failTime
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save"
        informativeText: qsTr("Sorry, start time must be before end time.")
    }

    MessageDialog{
        id:_failMessage
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save"
        informativeText: qsTr("Sorry, message is null.")
    }

    MessageDialog{
        id:_failToSave
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save"
        informativeText: qsTr("Sorry, the date you selected should be after today. Please choose a new date")
    }

    MessageDialog {
        id:_noSchedule
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"No schedule"
        informativeText: qsTr("Sorry, the date you have selected does not currently have a schedule")
    }
    FileDialog {
        id: _fileSave
        title: "Select some text files"
        modality: Qt.ApplicationModal
        currentFolder: StandardPaths.writableLocation
                       (StandardPaths.DocumentsLocation)
        fileMode: FileDialog.SaveFile
        nameFilters: [ "Text files (*.txt *)" ]
    }

}


