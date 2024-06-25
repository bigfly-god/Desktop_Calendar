#include "ScreenshotHelper.h"
#include <QClipboard>
#include <QDebug>
#include <QDir>
#include <QQuickWindow>
#include <QStandardPaths>

ScreenshotHelper::ScreenshotHelper(QObject *parent)
    : QObject{parent}
{}

void ScreenshotHelper::saveImageToFile(const QString &fileName, int x, int y, int width, int height)
{
    auto screen = QGuiApplication::primaryScreen();
    if (!screen) {
        qWarning("无法获取主屏幕");
        return;
    }
    auto pixmap = screen->grabWindow(0, x, y, width, height);
    QString screenshotDirectory = "/root/QML期末实训/Desktop_Calendar/Screenshot";
    QDir dir(screenshotDirectory);
    if (!dir.exists()) {
        if (!dir.mkpath(screenshotDirectory)) {
            qWarning("无法创建截图目录: %s", qPrintable(screenshotDirectory));
            return;
        }
    }
    QString filePath = QDir(screenshotDirectory).filePath(fileName); // 构建完整的文件路径
    // 保存到文件
    if (!pixmap.save(filePath, "png")) {
        qWarning("无法保存截图到文件: %s", qPrintable(filePath));
    } else {
        qDebug("截图已保存到文件: %s", qPrintable(filePath));
    }
}
