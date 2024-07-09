import QtQuick 2.12

Rectangle {
    property alias eventText: _event.text
    property alias timeText: _time.text
        id: pop_cotent
        Rectangle
        {
            id: _rect
            width: 300
            height: 200
            color: "green"

            Column
            {
                anchors.centerIn: parent
                Text
                {
                    id:_event
                    text: "" // 显示事件名称
                    font.bold: true
                    font.pointSize: 16
                    wrapMode: Text.WordWrap
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
                Text
                {
                    id:_time
                    text: "" // 显示事件时间范围
                    wrapMode: Text.WordWrap
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
}
