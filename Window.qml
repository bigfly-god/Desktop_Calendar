import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "Desktop_Calendar.js" as Controller

ApplicationWindow {
    property alias actions: _actions
    property alias content: _content
    id:window
    width: 520
    height: 480
    minimumHeight: 400
    minimumWidth: 450
    maximumHeight: 600
    maximumWidth: 600
    visible: true
    title: qsTr("Calendar")

    menuBar:MenuBar {
        id:appMenuBar
        Menu{
             id:listMenu
             title:qsTr("&Schedule")
             MenuItem{action:actions.addSchedule}
             MenuItem{action:actions.modifySchedule}
             MenuItem{action:actions.deleteSchedule}
             MenuItem{action:actions.exit}
        }

        Menu{
            title:qsTr("&Menu")
            MenuItem{action:actions.eventCountdown}
            MenuItem{action:actions.note}

        }

        Menu{
            title:qsTr("&Help")
             MenuItem { action: actions.about }
        }
    }

    Actions {
        id:_actions
        about.onTriggered: content.dialogs.about.open()
        addSchedule.onTriggered: Controller.open_addScheduleDialog()
        modifySchedule.onTriggered: Controller.open_modifyScheduleDialog()
        deleteSchedule.onTriggered: Controller.open_deleteScheduleDialog()
        eventCountdown.onTriggered: content.dialogs.eventCountdown.open()
        note.onTriggered:Controller.createnote()
    }

    //Content Area
    Content {
        id:_content
        anchors.fill: parent
    }

    Component.onCompleted: {
        Controller.updateDateTime() // 在控件完成初始化后立即更新时间
    }

    Timer {
        interval: 1000  // 每秒更新一次时间
        running: true   // 定时器运行
        repeat: true    // 重复执行
        onTriggered: {
         Controller.updateDateTime()//每触发一次，更新一次label上时间显示
        }
    }
}
