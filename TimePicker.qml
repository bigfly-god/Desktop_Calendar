import QtQuick
import QtQuick.Controls

Item {
    id: timePicker
    property date currentDate: new Date()


    //小时
    ListModel {
        id: hoursModel

        Component.onCompleted: {
            for (var i = 0; i < 24; ++i) {
               append({ "hours": i });
            }
        }
    }

    ComboBox {
        id: hourComboBox
        focus:true
        anchors.left: start_text.right
        anchors.top: parent.top
        model: hoursModel
        width: 45
        delegate: Item {
            implicitWidth: 45 // 可以根据需要调整这个值
            implicitHeight: 30 // 可以根据需要调整这个值
            Text {
                id: hour_text
                text: model.hours
                color: "white"
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
            }

            TapHandler {
                  onTapped: {hourComboBox.currentIndex = index;
                             hourComboBox.popup.visible = false} //手动关闭ComboBox下拉菜单
              }

        }

        currentIndex: {
            var hour = currentDate.getHours();
            for (var i = 0; i < hoursModel.count; ++i) {
                if (hoursModel.get(i).hours === hour.toString())
                    return i;
            }
            return 0; // 如果时不在列表中，则返回第一项
        }



        onVisibleChanged: {
               if (!visible) {
                   console.log("myItem is no longer visible");
                  // 重新启用主窗口
                  calendar.enabled = true

               }
        }

    }

    Text{
        id: h_text
        anchors.left:hourComboBox.right
        anchors.leftMargin: 0
        text: "Hour"
        color:"white"
    }


   //分
    ListModel {
        id: minutesModel

        Component.onCompleted: {
            for (var i =0 ; i < 60; ++i) {
               append({ "minutes":  i });
            }
        }
    }

    ComboBox {
        id: minuteComboBox
        focus:true
        anchors.left: h_text.right
        anchors.top: parent.top
        anchors.leftMargin: 2
        model: minutesModel
         width: 45
        delegate: Item {
            implicitWidth: 45 // 可以根据需要调整这个值
            implicitHeight: 30 // 可以根据需要调整这个值
            Text {
                id: minute_text
                text: model.minutes
                color: "white"
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
            }

            TapHandler {

                  onTapped: {minuteComboBox.currentIndex = index;
                             minuteComboBox.popup.visible = false} //手动关闭ComboBox下拉菜单
              }

        }

        currentIndex: {
            var minute = currentDate.getMinutes();
            for (var i = 0; i < minutesModel.count; ++i) {
                if (minutesModel.get(i).minutes === minute.toString())
                    return i;
            }
            return 0; // 如果分不在列表中，则返回第一项
        }


        onVisibleChanged: {
               if (!visible) {
                   console.log("myItem is no longer visible");
                  // 重新启用主窗口
                  calendar.enabled = true

               }
        }

    }

    Text{
        id: mi_text
        anchors.left:minuteComboBox.right
        anchors.leftMargin: 0
        text: "Minute"
        color:"white"
    }


    //秒
     ListModel {
         id: secondsModel

         Component.onCompleted: {
             for (var i = 0; i < 60; ++i) {
                append({ "seconds":  i });
               }

         }
     }

     ComboBox {
         id: secondComboBox
         focus:true
         anchors.left: mi_text.right
         anchors.top: parent.top
         anchors.leftMargin: 2
         model: secondsModel
          width: 45
         delegate: Item {
             implicitWidth: 45 // 可以根据需要调整这个值
             implicitHeight: 30 // 可以根据需要调整这个值
             Text {
                 id: second_text
                 text: model.seconds
                 color: "white"
                 anchors.centerIn: parent
                 horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                 verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
             }

             TapHandler {

                   onTapped: {secondComboBox.currentIndex = index;
                              secondComboBox.popup.visible = false} //手动关闭ComboBox下拉菜单
               }

         }

         currentIndex: {
             var second = currentDate.getSeconds();
             for (var i = 0; i < secondsModel.count; ++i) {
                 if (secondsModel.get(i).seconds === second.toString())
                     return i;
             }
             return 0; // 如果秒不在列表中，则返回第一项
         }


         onVisibleChanged: {
                if (!visible) {
                    console.log("myItem is no longer visible");
                   // 重新启用主窗口
                   calendar.enabled = true

                }
         }

     }

     Text{
         id: s_text
         anchors.left:secondComboBox.right
         anchors.leftMargin: 0
         text: "Second"
         color:"white"
     }






}
