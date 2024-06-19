import QtQuick
import QtQuick.Controls
Item {
    property  alias exit:_exit
    property  alias about:_about
    property  alias schedule:_schedule
    property  alias modify:_modify
    property  alias save:_save
    property  alias countdown:_countdown

    Action{
        id:_exit
        text:qsTr("&Exit")
        icon.name:"application-exit"
        onTriggered: Qt.quit();
    }
    Action{
        id:_about
        text:qsTr("&About")
        icon.name:"help-about"
    }
    Action{
        id:_schedule
        text:qsTr("&Add schedule")
        icon.name:"application-edit"

    }
    Action{
        id:_save
        text:qsTr("&Save")
        icon.name: "document-save"
    }
    Action{
        id:_countdown
        text:qsTr("&Countdown")
        // icon.name:"hourglass"
    }


    Action{
        id:_modify
        text:qsTr("&Modify schedule")
        icon.name:"calendar"
    }

}


