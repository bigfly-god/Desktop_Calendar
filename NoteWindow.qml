import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Desktop_Calendar.js" as Controller

ApplicationWindow {
        id: _notebook
        title:qsTr("note")
        width: 350
        height: 200
        maximumHeight: 600
        minimumHeight: 200
        maximumWidth: 400
        minimumWidth: 320
        header: ToolBar {
            RowLayout{
                ToolButton{ action: actions.save }
                ToolButton{ action: actions.open }
                ToolButton{ action: actions.screenshot}
                ToolButton{ action: actions.exit1 }
            }
        }

        Actions {
            id:actions
            save.onTriggered: Controller.save();
            open.onTriggered: Controller.open();
            exit1.onTriggered: Controller.exitnote();
            screenshot.onTriggered: Controller.sreenshout();
        }

        Loader {
            id: screenShotCom
            onLoaded: {
                item.closing.connect(function (){screenShotCom.source = "";});
            }
        }

        Content1 {
            id:contente1
            anchors.fill: parent
        }


}
