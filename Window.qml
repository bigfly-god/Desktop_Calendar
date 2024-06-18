import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ApplicationWindow {
    id:window
    width: 520
    height: 480
    visible: true
    title: qsTr("Calendar")

    MyCalendar {
        id:calendar
        anchors.fill: parent
    }
}
