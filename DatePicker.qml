import QtQuick
import QtQuick.Controls

Item {
    id: datePicker
    property date currentDate: new Date()

    ListModel {
        id: yearsModel

        Component.onCompleted: {
            var currentYear = currentDate.getFullYear();
            for (var i = 0; i < 11; ++i) {
               append({ "display": currentYear + i });
            }
        }
    }

    ComboBox {
        id: yearComboBox
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        model: yearsModel

        delegate: Item {
            implicitWidth: 100 // 你可以根据需要调整这个值
            implicitHeight: 30 // 你可以根据需要调整这个值

            Text {
                id: text
                text: model.display
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter // 设置文本水平居中对齐
                verticalAlignment: Text.AlignVCenter // 设置文本垂直居中对齐
            }

            TapHandler {
                  id: tapHandler
                  onTapped: yearComboBox.currentIndex = index;
              }

        }

        currentIndex: {
            var year = currentDate.getFullYear();
            for (var i = 0; i < yearsModel.count; ++i) {
                if (yearsModel.get(i).display === year.toString())
                    return i;
            }
            return 0; // 如果年份不在列表中，则返回第一项
        }

        onCurrentIndexChanged: {
            var year = yearsModel.get(currentIndex).display;
            currentDate.setFullYear(parseInt(year));
            // 这里可以发出一个信号来通知年份已更改
        }
    }

}
