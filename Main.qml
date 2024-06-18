import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("hello, world")
    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem { action:open }
            MenuItem { action:quit }
        }
    }

    header: ToolBar {
        RowLayout{
            ToolButton{ action: open }
            ToolButton{ action: quit }
        }
    }

    Action {
        id: open
        text: qsTr("&Open...")
        icon.name: "document-open"
        shortcut: "StandardKey.Open"
        onTriggered: console.log("Open action triggered");
    }

    Action {
        id: quit
        text: qsTr("&Quit")
        icon.name: "application-exit"
        onTriggered: Qt.quit();
    }

    //Content Area
    TextArea {
        text: qsTr("hello, world")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
