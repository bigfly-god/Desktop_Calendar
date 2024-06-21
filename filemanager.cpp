#include "filemanager.h"

FileManager::FileManager(QObject *parent)
    : QObject(parent)
{}

bool FileManager::writeToFile(const QString &fileName, const QString &data)
{
    QFile file(fileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    QTextStream out(&file);
    out << data;
    file.close();
    return true;
}

QString FileManager::readFromFile(const QString &fileName)
{
    QFile file(fileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return QString();

    QTextStream in(&file);
    QString data = in.readAll();
    file.close();
    return data;
}
