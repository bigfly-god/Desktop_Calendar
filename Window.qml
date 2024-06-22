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

    menuBar:MenuBar{
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
            title:qsTr("Menu")
            MenuItem{action:actions.eventCountdown}
            MenuItem{action:actions.note}

        }

        Menu{
            title:qsTr("&Help")
             MenuItem { action: actions.about }

        }
    }


    Actions{
        id:_actions
        about.onTriggered: content.dialogs.about.open()
        addSchedule.onTriggered: Controller.open_addEventDialog()
        eventCountdown.onTriggered: content.dialogs.eventCountdown.open()
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

        // 顶层窗口，放置按钮
//         Window {
//                id: buttonWindow
//                visible: true
//                width: 100
//                height: 50
//                flags: Qt.Tool | Qt.FramelessWindowHint
//                x: Screen.desktopAvailableWidth - width - 10
//                y: 10
//                color: "transparent"

//                Rectangle {
//                    width: 100
//                    height: 50
//                    color: "lightblue"
//                    border.color: "black"
//                    radius: 10

//                        MouseArea {
//                            anchors.fill: parent
//                            onClicked: {
//                                // Call function from external JS file
//                                AppFunctions.openNotePopup(buttonWindow.x, buttonWindow.y + buttonWindow.height);
//                            }
//                        }
//                        }
//                    }

//                    Text {
//                        anchors.centerIn: parent
//                        text: "Create Note"
//                        font.bold: true
//                        font.pixelSize: 14
//                    }
//                }
//            }

// }

}
