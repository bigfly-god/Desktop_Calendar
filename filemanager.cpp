#include "filemanager.h"
#include <QFile>
#include <QTextStream>

FileManager::FileManager(QObject* parent)
    : QObject(parent)
{}

bool FileManager::isValidDate(const QDate& date) const
{
    return date >= QDate::currentDate();
}

QString FileManager::generateFileName(const QDate& date) const
{
    return "/" + date.toString("yyyy-MM-dd") + ".txt";
}

void FileManager::saveToFile(const QString& fileName, const QString& data) const
{
    QFile file(fileName);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << data;
        file.close();
    }
}

Schedule FileManager::readFromFile(const QString& fileName) const
{
    Schedule schedule;
    QFile file(fileName);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        QString data = in.readAll();
        schedule = deserializeSchedule(data);
        file.close();
    }
    return schedule;
}

QString FileManager::serializeSchedule(const Schedule& schedule) const
{
    QString result;
    result += schedule.eventName + ";";               // 存储事件名称
    result += schedule.startTime.toString() + ";";    // 存储开始时间
    result += schedule.endTime.toString() + ";";      // 存储结束时间
    result += schedule.reminderTime.toString() + ";"; // 存储提醒时间
    // 添加其他需要存储的成员
    return result;
}

Schedule FileManager::deserializeSchedule(const QString& data) const
{
    QStringList parts = data.split(";");
    Schedule schedule;
    schedule.eventName = parts[0];                       // 读取事件名称
    schedule.startTime = QTime::fromString(parts[1]);    // 读取开始时间
    schedule.endTime = QTime::fromString(parts[2]);      // 读取结束时间
    schedule.reminderTime = QTime::fromString(parts[3]); // 读取提醒时间
    return schedule;
}

bool FileManager::hasSchedule(const QDate& date) const
{
    QString fileName = generateFileName(date);
    QFile file(fileName);
    return file.exists();
}

Schedule FileManager::getSchedule(const QDate& date) const
{
    QString fileName = generateFileName(date);
    Schedule schedule = readFromFile(fileName);
    return schedule;
}

void FileManager::addOrUpdateSchedule(const QDate& date, const Schedule& schedule)
{
    QString fileName = generateFileName(date);
    QString data = serializeSchedule(schedule);
    saveToFile(fileName, data);
}

void FileManager::removeSchedule(const QDate& date)
{
    QString fileName = generateFileName(date);
    QFile file(fileName);
    file.remove();
}

QString FileManager::storagePath() const
{
    return m_storagePath;
}

void FileManager::setStoragePath(const QString& path)
{
    if (m_storagePath != path) {
        m_storagePath = path;
        emit storagePathChanged();
    }
}

Schedule FileManager::setSchedule(const QString& eventName,
                                  const QTime& startTime,
                                  const QTime& endTime,
                                  const QTime& reminderTime) const
{
    Schedule schedule;
    schedule.eventName = eventName;
    schedule.startTime = startTime;
    schedule.endTime = endTime;
    schedule.reminderTime = reminderTime;
    return schedule;
}
