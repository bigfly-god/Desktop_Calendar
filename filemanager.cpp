#include "filemanager.h"
#include <QDate>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QDirIterator>
#include <QFile>
#include <QFileInfo>
#include <QString>
#include <QTextStream>
#include <QTime>

FileManager::FileManager(QObject* parent)
    : QObject(parent)
{}

bool FileManager::isValidDate(const QDate& date) const
{
    return date >= QDate::currentDate();
}

QString FileManager::generateFileName(const QDate& date) const
{
    return "/root/Desktop_Calendar/schedule/" + date.toString("yyyy-MM-dd");
}

QString FileManager::generateFileName(const QDate& date, const QTime& time) const
{
    return "/root/Desktop_Calendar/schedule/" + date.toString("yyyy-MM-dd")
           + time.toString("HH:mm:ss") + ".txt";
}

QString FileManager::generateFileName(const QDate& date, const QString& time) const
{
    QString directoryPath = generateFileName(date);
    QString fileName = time + ".txt"; // 根据需要修改文件名
    QString filePath = QDir(directoryPath).filePath(fileName);
    return filePath;
}

void FileManager::saveToFile(const QString& fileName,
                             const QDate& date,
                             const QTime& time,
                             const QString& data) const
{
    // 提取文件的目录部分
    QString directory = QFileInfo(fileName).absolutePath() + "/" + date.toString("yyyy-MM-dd");

    QString filePath = QDir(directory).filePath(time.toString("HH:mm:ss") + ".txt");

    // 使用QDir来创建目录（如果它不存在）
    QDir dir;
    if (!dir.exists(directory)) {
        if (!dir.mkpath(directory)) {
            // 处理目录创建失败的情况
            return;
        }
    }
    QFile file(filePath);
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
    result += schedule.eventDate.toString() + ";";    // 存储事件日期
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
    schedule.eventName = parts[0]; // 读取事件名称
    schedule.eventDate = QDate::fromString(parts[1]);
    schedule.startTime = QTime::fromString(parts[2]);    // 读取开始时间
    schedule.endTime = QTime::fromString(parts[3]);      // 读取结束时间
    schedule.reminderTime = QTime::fromString(parts[4]); // 读取提醒时间
    return schedule;
}

bool FileManager::hasSchedule(const QDate& date) const
{
    QString fileName = generateFileName(date);
    QDir dir(fileName);
    return dir.exists();
}

//读取所有日程
QList<Schedule> FileManager::getAllSchedules()
{
    QString directory = "/root/Desktop_Calendar/schedule/";
    QStringList filters;
    filters << "*.txt";

    QDirIterator it(directory, filters, QDir::Files | QDir::Dirs, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString fileName = it.next();
        // 从文件中读取日程信息
        Schedule schedule = readFromFile(fileName);
        allSchedules.append(schedule);
    }

    // 按照事件日期和开始时间排序
    std::sort(allSchedules.begin(), allSchedules.end(), [](const Schedule& a, const Schedule& b) {
        if (a.eventDate != b.eventDate) {
            return a.eventDate < b.eventDate;
        } else {
            return a.startTime < b.startTime;
        }
    });

    // 返回所有日程信息列表
    return allSchedules;
}

//读取某天日程
QList<Schedule> FileManager::getDaySchedules(const QDate& date) const
{
    QString directory = QString("/root/Desktop_Calendar/schedule/%1/")
                            .arg(date.toString("yyyy-MM-dd"));
    QStringList filters;
    filters << "*.txt";

    QList<Schedule> schedulesForDate;

    QDirIterator it(directory, filters, QDir::Files | QDir::Dirs, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString fileName = it.next();
        // 从文件中读取日程信息
        Schedule schedule = readFromFile(fileName);
        schedulesForDate.append(schedule);
    }
    // 返回所有日程信息
    return schedulesForDate;
}

QVariantList FileManager::getSchedulesAsVariantList(const QDate& date) const
{
    QVariantList list;
    for (const Schedule& schedule : getDaySchedules(date)) {
        QVariantMap map;

        map["eventName"] = schedule.eventName;
        QString startTimeStr = schedule.startTime.toString("hh:mm:ss");
        QString endTimeStr = schedule.endTime.toString("hh:mm:ss");
        QString reminderTimeStr = schedule.reminderTime.toString("hh:mm:ss");
        map["startTime"] = startTimeStr;
        map["endTime"] = endTimeStr;
        map["reminderTime"] = reminderTimeStr;
        list.append(map);
    }
    return list;
}

QVariantList FileManager::getAllSchedulesAsVariantList()
{
    QVariantList list;
    for (const Schedule& schedule : getAllSchedules()) {
        QVariantMap map;

        map["eventName"] = schedule.eventName;
        QString dateStr = schedule.eventDate.toString("yyyy-MM-dd");
        QString startTimeStr = schedule.startTime.toString("hh:mm:ss");
        QString endTimeStr = schedule.endTime.toString("hh:mm:ss");
        QString reminderTimeStr = schedule.reminderTime.toString("hh:mm:ss");

        map["eventDate"] = dateStr;
        map["startTime"] = startTimeStr;
        map["endTime"] = endTimeStr;
        map["reminderTime"] = reminderTimeStr;

        list.append(map);
    }
    return list;
}

QList<Schedule> FileManager::getSchedule(const QDate& date) const
{
    QString directoryPath = generateFileName(date);
    QStringList filters;
    filters << "*.txt";

    QDirIterator it(directoryPath, filters, QDir::Files | QDir::Dirs, QDirIterator::Subdirectories);
    QList<Schedule> schedules;

    while (it.hasNext()) {
        QString fileName = it.next();
        // 从文件中读取日程信息
        Schedule schedule = readFromFile(fileName);
        schedules.append(schedule);
    }

    // 按照事件日期和开始时间排序
    std::sort(schedules.begin(), schedules.end(), [](const Schedule& a, const Schedule& b) {
        if (a.eventDate != b.eventDate) {
            return a.eventDate < b.eventDate;
        } else {
            return a.startTime < b.startTime;
        }
    });

    return schedules;
}

Schedule FileManager::getOneSchedule(const QDate& date, const QTime& time) const
{
    QString directoryPath = generateFileName(date, time);

    Schedule schedule;
    schedule = readFromFile(directoryPath);
    return schedule;
}
Schedule FileManager::getOneSchedule2(const QDate& date) const
{
    QString string = "12:00:00";
    QString directoryPath = generateFileName(date);
    QString fileName = string + ".txt";                        // 根据需要修改文件名
    QString filePath = QDir(directoryPath).filePath(fileName); // 构建完整文件路径

    Schedule schedule;
    schedule = readFromFile(filePath);
    return schedule;
}

void FileManager::addOrUpdateSchedule(const QDate& date, const QTime& time, const Schedule& schedule)
{
    QString fileName = generateFileName(date, time);
    QString data = serializeSchedule(schedule);
    saveToFile(fileName, date, time, data);
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
                                  const QDate& eventDate,
                                  const QTime& startTime,
                                  const QTime& endTime,
                                  const QTime& reminderTime) const
{
    Schedule schedule;
    schedule.eventName = eventName;
    schedule.eventDate = eventDate;
    schedule.startTime = startTime;
    schedule.endTime = endTime;
    schedule.reminderTime = reminderTime;
    return schedule;
}

QString FileManager::getEventName(const Schedule& schedule) const
{
    return schedule.eventName;
}

QTime FileManager::returnStartTime(const QString& timeString) const
{
    QTime time = QTime::fromString(timeString, "HH:mm:ss");
    return time;
}

QString FileManager::getString(const QString& string) const
{
    return string;
}
