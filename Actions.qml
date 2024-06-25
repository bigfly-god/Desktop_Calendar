import QtQuick
import QtQuick.Controls

Item {
    property  alias exit:_exit
    property  alias exit1:_exit1
    property  alias about:_about
    property  alias addSchedule:_addSchedule
    property  alias modifySchedule:_modifySchedule
    property  alias deleteSchedule:_deleteSchedule
    property  alias eventCountdown:_eventCountdown
    property  alias note: _note
    property  alias save: _save
    property alias screenshot: _screenshot

    Action{
        id:_exit
        text:qsTr("&Exit")
        icon.name:"application-exit"
        onTriggered: Qt.quit();
    }
    Action{
        id:_exit1
        text:qsTr("&Exit")
        icon.name:"application-exit"
    }
    Action{
        id:_about
        text:qsTr("&About")
        icon.name:"help-about"
    }
    Action{
        id:_addSchedule
        text:qsTr("&Add schedule")
        icon.name:"application-edit"
    }


    Action{
        id:_eventCountdown
        text:qsTr("&Countdown")
    }
    Action{
        id:_deleteSchedule
        text:qsTr("Delete schedule")
    }

    Action{
        id:_modifySchedule
        text:qsTr("&Modify schedule")
        icon.name:"calendar"
    }

    Action{
        id:_note
        text:qsTr("&Note")
    }
    Action {
        id: _save
        text: qsTr("&Save")
        shortcut: StandardKey.Save
        icon.name: "document-save"
    }
    Action{
        id:_screenshot
        text:qsTr("ScreenShot")
    }



}


