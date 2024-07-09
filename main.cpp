#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ScreenshotHelper.h"
#include "filemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    ScreenshotHelper Screenshot;
    // 注册 FileManager 类到 QML
    qmlRegisterType<FileManager>("FileManager", 1, 0, "FileManager");
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("g_screenShot", &Screenshot);

    engine.loadFromModule("Desktop_Calendar", "Window");

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    return app.exec();
}
