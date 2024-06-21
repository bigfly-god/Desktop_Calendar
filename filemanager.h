#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QFile>
#include <QObject>
#include <QTextStream>

class FileManager : public QObject
{
    Q_OBJECT

public:
    explicit FileManager(QObject *parent = nullptr);

    Q_INVOKABLE bool writeToFile(const QString &fileName, const QString &data);
    Q_INVOKABLE QString readFromFile(const QString &fileName);
};

#endif // FILEMANAGER_H
