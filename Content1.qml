import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ScrollView {
    id:view
    anchors.fill: parent
    ScrollBar.horizontal.policy: ScrollBar.AsNeeded
    ScrollBar.vertical.policy: ScrollBar.AsNeeded

    property alias textContent: _textContent

    function currentState(){
        return [_textContent.textDocument.modified,
                _textContent.isTitle()];
    }



    TextContent {
        id:_textContent
    }
}
