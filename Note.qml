import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 200
    height: 100
    color: "lightyellow"
    border.color: "black"
    radius: 10
    visible: false  // 默认不可见

    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: 10
        font.pixelSize: 14
        wrapMode: Text.WordWrap

        onTextChanged: {
            if (input.text === "") {
                input.font.bold = false;  // 使用粗体表示占位符
                input.font.italic = true; // 使用斜体表示占位符
                input.text = "Enter your note...";
            } else {
                input.font.bold = true;
                input.font.italic = false;
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                input.focus = true;
            }
        }
    }
}
