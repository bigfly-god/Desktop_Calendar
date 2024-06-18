import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow{
    width: 520
    height: 480
    visible: true
    title: qsTr("Calendar")

    MyCalendar {
        anchors.centerIn: parent
    }
}


