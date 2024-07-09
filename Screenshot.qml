import QtQuick
import QtQuick.Controls
import QtQuick.Window
import "Desktop_Calendar.js" as Controller

Window {
    id: root

    readonly property int borderMargin: 3
    readonly property color tranparentColor: "transparent"       //透明色
    readonly property color blurryColor: Qt.rgba(0,0,0,0.3)      //模糊色
    readonly property color selectBorderColor: "green"           //边框色

    signal  sigClose()

    color: tranparentColor
    visibility: ApplicationWindow.FullScreen
    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint

    //四个阴影区域，笼罩未选择区域
    //一个选择区域
    Rectangle{
        id: topRect
        anchors{
            top: parent.top
            left: parent.left
        }
        width: parent.width
        height: selectionRect.y
        color: blurryColor
    }

    Rectangle{
        id: leftRect
        anchors{
            top: topRect.bottom
            left: parent.left
        }
        width: selectionRect.x
        height: parent.height - topRect.height - bottomRect.height
        color: blurryColor
    }

    Rectangle{
        id: rightRect
        anchors{
            top: topRect.bottom
            right: parent.right
        }
        width: parent.width - leftRect.width - selectionRect.width
        height: leftRect.height
        color: blurryColor
    }

    Rectangle{
        id: bottomRect
        anchors{
            bottom: parent.bottom
            left: parent.left
        }
        width: parent.width
        height: parent.height - topRect.height - selectionRect.height
        color: blurryColor
    }


    Rectangle{
       color:tranparentColor
       anchors.fill: parent
        TapHandler
        {
              id:taparea
              property int startX:0
              property int startY:0
              property int endX:0
              property int endY:0
              onPressedChanged: {
                  if(pressed)
                  {
                      startX = point.position.x;
                      startY = point.position.y;
                      selectionRect.width = 0;
                      selectionRect.height = 0;
                      selectionRect.visible = true;
                      console.log("startY",startY)
                      console.log("startX",startX)
                  }
                  else
                      selectionRect.updateStartAndEndPoint();
                      functionRect.visible = true;
              }
              onPointChanged:  {
                      endX = point.position.x;
                      endY = point.position.y;
                     console.log("endY",endY)
                      selectionRect.width = Math.abs(endX - startX);
                      selectionRect.height = Math.abs(endY - startY);
                      selectionRect.x = Math.min(startX, endX);
                      selectionRect.y = Math.min(startY, endY);
                  }
              }
          }

    Rectangle {
        id: selectionRect
        property var startPoint
        property var endPoint
        function updateStartAndEndPoint() {
            startPoint = Qt.point(x, y);
            endPoint = Qt.point(x + width, y + height);
        }

        visible: false
        border.color: selectBorderColor
        border.width: 1
        color: tranparentColor
 DragHandler{
    target:parent
    cursorShape :Qt.SizeAllCursor
       }
}

        Item{
            id: resizeBorderItem
            anchors.centerIn: parent
            width: parent.width + borderMargin * 2
            height: parent.height + borderMargin * 2
        }


    Item{
        id: functionRect
        width: cancelBtn.width + oKBtn.width + 5
        height: cancelBtn.height
        visible: false
        anchors{
            top: selectionRect.bottom
            topMargin: 3
            right:selectionRect.right
        }

        Button{
            id: cancelBtn
            anchors{
                right: oKBtn.left
                verticalCenter: parent.verticalCenter
            }
            text: "退出"
            onClicked: {
                close();
            }
        }

        Button{
            id: oKBtn
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            text: "完成"
            onClicked: {
                 //Controller.save()
                var  timestamp =Controller. getTimestamp();
                Controller.captureScreenshot(timestamp,selectionRect.x,selectionRect.y,selectionRect.width,selectionRect.height)
                close();
                content.notewindow.visible=true
                 }
            }
        }

}
