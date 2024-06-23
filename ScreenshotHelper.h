#ifndef SCREENSHOTHELPER_H
#define SCREENSHOTHELPER_H

#include <QDateTime>
#include <QGuiApplication>
#include <QObject>
#include <QPixmap>
#include <QQuickWindow>
#include <QScreen>

class ScreenshotHelper : public QObject
{
    Q_OBJECT
public:
    explicit ScreenshotHelper(QObject *parent = nullptr);

    Q_INVOKABLE void saveImageToClipboard(int x = 0, int y = 0, int width = -1, int height = -1);
signals:
};

#endif // SCREENSHOTHELPER_H
