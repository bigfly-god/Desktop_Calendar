import QtQuick
import QtQuick.Controls

Item{
    property alias open: _open
    property alias save: _save
    property alias quit: _quit
    property alias about: _about

    Action {
        id: _open
        text: qsTr("&Open...")
        icon.name: "document-open"
        shortcut: StandardKey.Open
        // onTriggered: console.log("Open action triggered");
    }

    Action {
        id: _save
        text: qsTr("&Save")
        shortcut: StandardKey.Save
        icon.name: "document-save"
    }

    Action {
        id: _quit
        text: qsTr("&Quit")
        icon.name: "application-exit"
        shortcut: "Ctrl+q"
        onTriggered: Qt.quit();
    }

    Action {
        id: _about
        text: qsTr("&About")
        icon.name: "help-about"
    }
}
