import QtQuick

Window{
    id:newwindow
    visible: false
     width: 400
     height: 300
     title: "Date Popup"

     // 这里是新窗口的内容，比如一些文本、按钮等
     Text {
         text: "You've double-clicked a date!"
         anchors.centerIn: parent
     }
}
