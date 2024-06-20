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

        Dialogs{
            id:dialogs
            anchors.fill: parent
        }

        Actions{
            id:actions
            about.onTriggered: dialogs.about.open()
            event_countdown.onTriggered: dialogs.eventCountdown.open()
        }

        MyCalendar {
        id:calendar
        anchors.fill:parent
        }

        Component.onCompleted: {
            updateDateTime() // 在控件完成初始化后立即更新时间
        }

        function updateDateTime() {
        var currentTime = new Date()
        window.title = currentTime.toLocaleString(Qt.locale("de_DE"),"yyyy-MM-dd hh:mm:ss")
        }

        Timer {
            interval: 1000  // 每秒更新一次时间
            running: true   // 定时器运行
            repeat: true    // 重复执行
            onTriggered: {
                window.updateDateTime()//每触发一次，更新一次label上时间显示
            }
        }

}


