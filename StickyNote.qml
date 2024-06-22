import QtQuick
import QtQuick.Controls

Item {
    property alias stickynote:_stickyNote
    id:_stickyNote
    width: 200
    height: 150
    visible: false
    property string noteText: "Enter your note here"

    Rectangle {
        width: parent.width
        height: parent.height
        color: "lightyellow"
        border.color: "orange"
        radius: 10
        border.width: 2

        TextEdit {
            id: noteTextEdit
            anchors.fill: parent
            wrapMode: TextEdit.Wrap
            selectByMouse: true

            font.pixelSize: 16
            color: "black"
            selectByKeyboard: true
            clip: true

            onTextChanged: {
                parent.noteText = noteTextEdit.text;
            }
        }
    }
}
