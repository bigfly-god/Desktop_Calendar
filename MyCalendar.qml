import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "Desktop_Calendar.js" as Controller

Item{
    property alias control:_control
    property alias month_grid:month_grid
Rectangle {
    id:_control
    anchors.fill: parent
    implicitWidth: 520
    implicitHeight: 350
    border.color: "#404040"
    property alias font: month_grid.font
    property alias locale: month_grid.locale
    property date selectDate: new Date()
    //自定义按钮样式
    component CalendarButton : AbstractButton {
        id: c_btn
        implicitWidth: 30
        implicitHeight: 30
        contentItem: Text {
            font: control.font
            text: c_btn.text
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Item{}
    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 2
        columns: 1
        rows: 3
        columnSpacing: 1
        rowSpacing: 1
       WheelHandler{
           onWheel:(event)=> {
                       if (event.angleDelta.y > 0) {
                           if(month_grid.month===11){
                               month_grid.year+=1;
                               month_grid.month=0;
                           }else{
                               month_grid.month+=1;
                           }
                       }
                           else if (event.angleDelta.y < 0) {
                       if(month_grid.month===0){
                           month_grid.year-=1;
                           month_grid.month=11;
                   }else{
                           month_grid.month-=1;
                           }
                       }
                   }
       }

        //年、月切换
        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 45
            color:"#404040"
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                CalendarButton {
                    text: "<"
                    TapHandler{
                        onTapped: {
                            month_grid.year-=1;
                        }
                    }
                }

                Text {
                    font: control.font
                    color: "white"
                    text: month_grid.year
                }

                CalendarButton {
                    text: ">"
                    TapHandler{
                        onTapped: {
                            month_grid.year+=1;
                        }
                    }
                }

                Item {
                    implicitWidth: 15
                }
                CalendarButton {
                    text: "<"

                    Layout.maximumWidth: 20// 假设的最大宽度
                    onClicked: {
                        if(month_grid.month===0){
                            month_grid.year-=1;
                            month_grid.month=11;
                    }else{
                            month_grid.month-=1;
                        }
                    }
                }
                Text {
                    font: control.font
                    color: "white"
                    text: month_grid.month+1
                    Layout.fillWidth: true
                    Layout.maximumWidth: 20
                    horizontalAlignment: Text.AlignHCenter // 文本水平居中
                    verticalAlignment: Text.AlignVCenter // 文本垂直居中
                }
                CalendarButton {
                    text: ">"
                                Layout.maximumWidth: 20
                    onClicked: {
                        if(month_grid.month===11){
                            month_grid.year+=1;
                            month_grid.month=0;
                        }else{
                            month_grid.month+=1;
                        }
                    }
                }
                Rectangle{
                    width: 45
                    height: 45
                    radius: width / 2
                    Layout.alignment: Qt.AlignRight
                    color: "#E32636"
                    Text {
                        color: "white"
                        text: "Today"
                        anchors.centerIn: parent
                    }
                    TapHandler {
                        onTapped:  {
                            let cur_date = new Date();
                            month_grid.year = cur_date.getUTCFullYear();
                            month_grid.month = cur_date.getUTCMonth();
                            control.selectDate = cur_date;
                        }

                    }
                }
            }
        }

            //星期1-7
       Rectangle {
               color: "white"
               Layout.fillWidth: true
               Layout.preferredHeight: 40


                GridLayout {
                   columns: 7
                   rowSpacing: 0
                   columnSpacing: 0
                   anchors.fill: parent

                   Repeater {
                       model: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
                       delegate: Rectangle {
                           color: "#404040"
                           anchors.bottomMargin: 1
                           Layout.fillWidth: true
                           Layout.fillHeight: true

                           Text {
                               text: modelData
                               anchors.centerIn: parent
                               color: "white"
                           }

                       }
                   }
               }
           }
       //日期单元格
  MonthGrid {
      id: month_grid
      Layout.fillWidth: true
      Layout.fillHeight: true
      locale: Qt.locale("zh_CN")
      spacing: 1
      font{
          family: "SimHei"
          pixelSize: 14
      }
      delegate: Rectangle {
          id:delegateRect
          color: model.today?"#E32636":control.selectDate.valueOf()===model.date.valueOf()?"mediumturquoise":"#404040"
          border.color: "#404040"
          border.width: 1
          Rectangle {
              anchors.fill: parent
              anchors.margins: 2
              color: "transparent"
          }

          Rectangle{
              id:_bluerectangle
              width: 6
                     height: 6
                     radius: 3
                     color: "blue"
                     visible:content.fileManager.hasSchedule(model.date)
                     anchors {
                         horizontalCenter: parent.horizontalCenter // 水平居中
                         bottom: parent.bottom
                         margins: 10
                     }
          }


          Text {
              anchors.centerIn: parent
              text: model.day
              color: model.month===month_grid.month?"white":"black"
          }

          TapHandler {
              onTapped: {
                      control.selectDate = model.date;
                      console.log('click',month_grid.title,month_grid.year,month_grid.month+1,"--",
                      model.date.getUTCFullYear(),model.date.getUTCMonth()+1,model.date.getUTCDate(),model.date.getUTCDay())
               }
              onDoubleTapped: {
                       Controller.showPopup(model.date);
               }
           }
       }


   }


   }
 }

}

