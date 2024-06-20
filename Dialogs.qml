import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs
Item {
    property alias about: _about
    property alias addEventDialog:  addEventDialog

    ListModel {
        id: eventModel
        ListElement { date: "2024-06-21"; message: "Meeting with clients" }
        ListElement { date: "2024-06-22"; message: "Birthday party" }
        // Add more events as needed
    }

    Dialog {
            id: addEventDialog
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


    MessageDialog{
        id:_about
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Desktop_Calendar is Desktop memo"
        informativeText: qsTr("      Desktop memo is a free software that allows you to set a schedule and remind you of your own schedule.It also supports multiple people sharing and modifying the same memo.")
    }

}

