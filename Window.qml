import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Desktop_Calendar.js" as Controller

ApplicationWindow {
    id:window
    width: 520
    height: 480
    minimumHeight: 400
    minimumWidth: 400
    maximumHeight: 600
    maximumWidth: 600
    visible: true
    title: qsTr("Calendar")

    menuBar:MenuBar{
        id:appMenuBar
        Menu{
             id:listMenu
             title:qsTr("&List")
             MenuItem{action:actions.save}
             MenuItem{action:actions.schedule}
             MenuItem{action:actions.modify}
             MenuItem{action:actions.event_countdown}
             MenuItem{action:actions.exit}

        }

        Menu{
            title:qsTr("Menu")
            MenuItem{action:actions.schedulelist}
            MenuItem{action:actions.note}

        }

        Menu{
            title:qsTr("&Help")
             MenuItem { action: actions.about }

        }
    }

    Actions{
        id:actions
        about.onTriggered: content.dialogs.about.open()
        schedule.onTriggered: content.dialogs.addEventDialog.open()
        event_countdown.onTriggered: content.dialogs.eventCountdown.open()

    }


    //Content Area
    Content {
        id:content
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


