#include "filemanager.h"
#include <QDate>
#include <QFile>
#include <QString>
#include <QTextStream>

FileManager::FileManager(QObject* parent)
    : QObject(parent)
{}

bool FileManager::isValidDate(const QDate& date) const
{
    return date >= QDate::currentDate();
}

QString generateFilePathWithDate(const QDate& date)
{
    // 假设这是您的基本文件路径（不包括日期）
    QString basePath = "/root/Desktop_Calendar/schedual/";
    // 将日期转换为字符串格式 "yyyy-MM-dd"
    QString dateString = date.toString("yyyy-MM-dd");
    // 将日期字符串添加到文件路径中，并添加文件扩展名
    QString filePath = basePath + dateString;
    // 返回完整的文件路径
    return filePath;
}

QString FileManager::generateFileName(const QDate& date, const QTime& time) const
{
    return generateFilePathWithDate(date) + "   " + time.toString("HH:mm:ss") + ".txt";
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

bool FileManager::hasSchedule(const QDate& date, const QTime& time) const
{
    QString fileName = generateFileName(date, time);
    QFile file(fileName);
    return file.exists();
}

Schedule FileManager::getSchedule(const QDate& date, const QTime& time) const
{
    QString fileName = generateFileName(date, time);
    Schedule schedule = readFromFile(fileName);
    return schedule;
}

void FileManager::addOrUpdateSchedule(const QDate& date, const QTime& time, const Schedule& schedule)
{
    QString fileName = generateFileName(date, time);
    QString data = serializeSchedule(schedule);
    saveToFile(fileName, data);
}

void FileManager::removeSchedule(const QDate& date, const QTime& time)
{
    QString fileName = generateFileName(date, time);
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
