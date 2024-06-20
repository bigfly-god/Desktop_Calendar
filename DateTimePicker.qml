import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 150
    height: 50

    property int hour: 0
    property int minute: 0
    property int second: 0

    Row {
        anchors.fill: parent
        spacing: 5

        SpinBox {
            id: hourSpinBox
            from: 0
            to: 23
            value: root.hour
            editable: true
            width: 50

            onValueChanged: root.hour = value
        }

        Label {
            text: ":"
            width: 10
        }

        SpinBox {
            id: minuteSpinBox
            from: 0
            to: 59
            value: root.minute
            editable: true
            width: 50

            onValueChanged: root.minute = value
        }

        // 如果你需要秒的话
        Label {
            text: ":"
            visible: false // 注释掉或设置为false以隐藏秒
            width: 10
        }

        SpinBox {
            id: secondSpinBox
            from: 0
            to: 59
            value: root.second
            editable: true
            width: 50
            visible: false // 注释掉或设置为false以隐藏秒

            onValueChanged: root.second = value
        }
    }
}
