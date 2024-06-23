#include "ScreenshotHelper.h"
#include <QClipboard>
#include <QDebug>
#include <QQuickWindow>
#include <QStandardPaths>

ScreenshotHelper::ScreenshotHelper(QObject *parent)
    : QObject{parent}
{}

void ScreenshotHelper::saveImageToClipboard(int x, int y, int width, int height)
{
    auto screen = QGuiApplication::primaryScreen();
    auto pixmap = screen->grabWindow(0, x, y, width, height);

    auto clipboard = QGuiApplication::clipboard();
    if (clipboard) {
        clipboard->setPixmap(pixmap);
    }
}
