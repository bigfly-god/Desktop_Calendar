import QtQuick
import FileManager 1.0

Item {
    id:view
    anchors.fill: parent

    property alias dialogs: _dialogs
    property alias calendar: _calendar
    property alias fileManager: _fileManager

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
}
