import QtQuick
import QtQuick.Controls

Item {
    id: datePicker
    property date currentDate: new Date()

    Text{
        id: start_text
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: "start:"
        color:"white"
    }


    //从今年算起十年
    ListModel {
        id: yearsModel

        Component.onCompleted: {
            var currentYear = currentDate.getFullYear();
            for (var i = 0; i < 11; ++i) {
               append({ "years": currentYear + i });
            }
        }
    }

    ComboBox {
        id: yearComboBox
        focus:true
        anchors.left: start_text.right
        anchors.top: parent.top
        model: yearsModel
        width: 60
        delegate: Item {
            implicitWidth: 60 // 可以根据需要调整这个值
            implicitHeight: 30 // 可以根据需要调整这个值
            Text {
                id: year_text
                text: model.years
                color: "white"
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
            }

            TapHandler {

                  onTapped: {yearComboBox.currentIndex = index;
                             yearComboBox.popup.visible = false} //手动关闭ComboBox下拉菜单
              }

        }

        currentIndex: {
            var year = currentDate.getFullYear();
            for (var i = 0; i < yearsModel.count; ++i) {
                if (yearsModel.get(i).years === year.toString())
                    return i;
            }
            return 0; // 如果年份不在列表中，则返回第一项
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
        id: y_text
        anchors.left:yearComboBox.right
        anchors.leftMargin: 0
        text: "Year"
        color:"white"
    }

   //月
    ListModel {
        id: monthsModel

        Component.onCompleted: {
            for (var i = 1; i <= 12; ++i) {
               append({ "months":  i });
            }
        }
    }

    ComboBox {
        id: monthComboBox
        focus:true
        anchors.left: y_text.right
        anchors.top: parent.top
        anchors.leftMargin: 2
        model: monthsModel
         width: 45
        delegate: Item {
            implicitWidth: 45 // 可以根据需要调整这个值
            implicitHeight: 30 // 可以根据需要调整这个值
            Text {
                id: month_text
                text: model.months
                color: "white"
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
            }

            TapHandler {

                  onTapped: {monthComboBox.currentIndex = index;
                             monthComboBox.popup.visible = false} //手动关闭ComboBox下拉菜单
              }

        }

        currentIndex: {
            var month = currentDate.getMonth();
            for (var i = 0; i < monthsModel.count; ++i) {
                if (monthsModel.get(i).months === month.toString())
                    return i;
            }
            return 0; // 如果月份不在列表中，则返回第一项
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
        id: m_text
        anchors.left:monthComboBox.right
        anchors.leftMargin: 0
        text: "Month"
        color:"white"
    }


    //日
     ListModel {
         id: daysModel

         Component.onCompleted: {
            // if( month_text.text===1||3||5||7||8||10||12){
             for (var i = 1; i <= 31; ++i) {
                append({ "months":  i });
               }
             // }else if( month_text.text===4||6||9||11){
             //     for (var j = 1; j <= 30; ++j) {
             //        append({ "months":  j });
             //       }
             //     } else if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
             // {
             //     for (var h = 1; h <= 29 ; ++h) {
             //        append({ "months":  h });
             //       }
             // }else{
             //     for (var g = 1; g <= 29 ; ++g) {
             //        append({ "months":  g });
             //       }
             // }
         }
     }

     ComboBox {
         id: dayComboBox
         focus:true
         anchors.left: m_text.right
         anchors.top: parent.top
         anchors.leftMargin: 2
         model: daysModel
          width: 45
         delegate: Item {
             implicitWidth: 45 // 可以根据需要调整这个值
             implicitHeight: 30 // 可以根据需要调整这个值
             Text {
                 id: day_text
                 text: model.months
                 color: "white"
                 anchors.centerIn: parent
                 horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                 verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
             }

             TapHandler {

                   onTapped: {dayComboBox.currentIndex = index;
                              dayComboBox.popup.visible = false} //手动关闭ComboBox下拉菜单
               }

         }

         currentIndex: {
             var day = currentDate.getDate();
             for (var i = 0; i < daysModel.count; ++i) {
                 if (daysModel.get(i).days === day.toString())
                     return i;
             }
             return 0; // 如果月份不在列表中，则返回第一项
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
         id: d_text
         anchors.left:dayComboBox.right
         anchors.leftMargin: 0
         text: "Day"
         color:"white"
     }

}
