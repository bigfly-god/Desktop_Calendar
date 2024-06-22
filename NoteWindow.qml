import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Desktop_Calendar.js" as Controller

ApplicationWindow {
        id: _notebook
        title:qsTr("note")
        width: 500
        height: 400
        //visible: false
        property string noteText: ""
        header: ToolBar {
            RowLayout{
                ToolButton{ action: actions.save }
                ToolButton{ action: actions.exit }
            }
        }
        Actions{
            id:actions
            save.onTriggered: Controller.save();
        }
        Rectangle {
                id: noteBackground
                width: parent.width
                height: parent.height
                color: "lightyellow"
                border.color: "orange"
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
                        mcontent.notewindow.noteText = noteTextEdit.text;
                    }
                }
        }
}
