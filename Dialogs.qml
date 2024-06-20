import QtQuick
import QtCore
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    property alias about: _about
    property alias addEventDialog:_addEventDialog
    property alias popup:_popup
    property alias eventCountdown: _eventCountdown

    Dialog {
            id: _addEventDialog
            title: "Add Event"
            standardButtons: Dialog.Ok | Dialog.Cancel
            modal:true
            anchors.centerIn: parent
            width:parent.width-20
            height:parent.height/2
            opacity: 0.8 // 设置透明度为 80%

            TextField {
                id: _eventMessageInput
                placeholderText: "Enter event message..."
                width: parent.width - 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
            }

    DatePicker{
      anchors.top:_eventMessageInput.bottom
    }
}

    Dialog {
        id: _eventCountdown
        title: qsTr("事件倒计时")
        width: 200
        height: 400

        ScrollView {
            anchors.fill: parent
            clip: true // Ensures content is clipped to ScrollView bounds

            Column {
                // Your content goes here
                Repeater {
                    model: 20 // Example number of items, adjust as needed
                    Text {
                        text: "Item " + (index + 1)
                        font.pixelSize: 16
                        color: "white"
                        padding: 10
                    }
                }
            }
        }
     }

    MessageDialog{
        id:_about
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Desktop_Calendar is Desktop memo"
        informativeText: qsTr("      Desktop memo is a free software that allows you to set a schedule and remind you of your own schedule.It also supports multiple people sharing and modifying the same memo.")
    }

    Popup {
        id:_popup
        width: Math.min(window.width * 0.6, 600)
        height: width
        modal: false  // 设置为非模态
        visible: false
        opacity: 0.5
        anchors.centerIn: parent
        contentItem: Rectangle {
            anchors.fill: parent
            color: "grey"
            Text {
                anchors.centerIn: parent
                text: "Popup Content"
                font.pixelSize: 24
                color: "white"
            }
       }
    }
  }


