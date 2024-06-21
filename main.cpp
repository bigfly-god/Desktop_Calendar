#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "filemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    //engine.rootContext()->setContextProperty("FileManager", &FileManager); // 注册到QML

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("Desktop_Calendar", "Window");

    return app.exec();
}
