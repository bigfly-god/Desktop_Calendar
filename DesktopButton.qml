import QtQuick
import QtQuick.Controls

Item {
    width: 100 // 设置按钮窗口的宽度
    height: 50 // 设置按钮窗口的高度

    // 假设我们想要一个透明的背景，所以不需要设置颜色

    Button {
        id: desktopButton
        text: "Desktop Button" // 按钮上显示的文本
        anchors.right: parent.right // 将按钮的右边锚定到父元素的右边
        anchors.top: parent.top // 将按钮的顶部锚定到父元素的顶部
        anchors.rightMargin: 10 // 右边距，可以根据需要调整
        anchors.topMargin: 10 // 顶部边距，可以根据需要调整

        // 你可以在这里添加更多的按钮样式设置，比如背景色、字体等
    }
}
