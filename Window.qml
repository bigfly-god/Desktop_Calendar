import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ApplicationWindow {
    id:window
    width: 520
    height: 480
    visible: true
    title: qsTr("Calendar")

    menuBar:MenuBar{
        id:appMenuBar

        Menu{
             id:listMenu
             title:qsTr("List")
             MenuItem{action:actions.save}
             MenuItem{action:actions.schedule}
             MenuItem{action:actions.modify}
             MenuItem{action:actions.countdown}
             MenuItem{action:actions.exit}

        }
        Menu{
            title:qsTr("&Help")
             MenuItem { action: actions.about }

        }
    }

        Dialogs{
            id:dialogs
            anchors.fill: parent

        }

        Actions{
            id:actions
            about.onTriggered: dialogs.about.open()
            schedule.onTriggered: dialogs.addEventDialog.open()
        }

    MyCalendar {
        id:calendar
        anchors.fill: parent
    }
}
