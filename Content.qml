import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import FileManager 1.0

ScrollView {
    id:view
    anchors.fill: parent
    ScrollBar.horizontal.policy: ScrollBar.AsNeeded
    ScrollBar.vertical.policy: ScrollBar.AsNeeded

    property alias dialogs: _dialogs
    property alias calendar: _calendar
    property alias fileManager: _fileManager
    property alias notewindow: _notewindow


    Dialogs {
        id:_dialogs
        anchors.fill: parent
    }

    MyCalendar {
        id:_calendar
        anchors.fill:parent
    }

    FileManager {
        id:_fileManager
    }

    NoteWindow{
        id:_notewindow
        visible:false
    }

    TextContent {
        id:_textContent
    }
}


