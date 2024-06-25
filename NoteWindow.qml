import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Desktop_Calendar.js" as Controller

ApplicationWindow {
        id: _notebook
        title:qsTr("note")
        width: 300
        height: 200
        maximumHeight: 600
        minimumHeight: 200
        maximumWidth: 400
        minimumWidth: 200
        //visible: false
        property string noteText: ""
        header: ToolBar {
            RowLayout{
                ToolButton{ action: actions.save }
                ToolButton{ action: actions.screenshot}
                ToolButton{ action: actions.exit1 }
            }
        }

        Actions {
            id:actions
            save.onTriggered: Controller.save();
            exit1.onTriggered: Controller.exitnote();
            screenshot.onTriggered: Controller.sreenshout()
        }
        Loader {
            id: screenShotCom
            onLoaded: {
                item.closing.connect(
                            function (){
                    screenShotCom.source = "";
                });
            }
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
