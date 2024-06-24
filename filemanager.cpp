#include "filemanager.h"
#include <QDateTime>
#include <QDebug>
#include <QDate>
#include <QString>
#include <QDir>
#include <QDirIterator>
#include <QFile>
#include <QFileInfo>
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
    return "/root/Desktop_Calendar/schedule/" + date.toString("yyyy-MM-dd");
}

QString FileManager::generateFileName(const QDate& date, const QTime& time) const
{
    return "/root/Desktop_Calendar/schedule/" + date.toString("yyyy-MM-dd")
           + time.toString("HH:mm:ss") + ".txt";
}

void FileManager::saveToFile(const QString& fileName,
                             const QDate& date,
                             const QTime& time,
                             const QString& data) const
{
    //QFile file(fileName);
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
    QDir dir(fileName);
    return dir.exists();
}
//读取所有日程
Schedule FileManager::getAllSchedules() const
{
    QString directory = "/root/Desktop_Calendar/schedule/";
    QStringList filters;
    filters << "*.txt";

    QDirIterator it(directory, filters, QDir::Files | QDir::Dirs, QDirIterator::Subdirectories);
    Schedule schedule;

    while (it.hasNext()) {
        QString fileName = it.next();
        qDebug() << fileName << " ";
        // 从文件中读取日程信息
        schedule = readFromFile(fileName);

        // 返回日程信息
    }
    return schedule;
}

//读取选定日期的日程
Schedule FileManager::getSchedule(const QDate& date) const
{
    //QString fileName = generateFileName(date);
    QString directory = "/root/Desktop_Calendar/schedule/";
    QStringList filters;
    filters << "*.txt";

    QDirIterator it(directory, filters, QDir::Files, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString fileName = it.next();
        QFileInfo fileInfo(fileName);

        // 从文件名中提取时间部分，格式为 HH:mm:ss.txt
        QString baseName = fileInfo.baseName();
        // 提取 "HH:mm:ss"
        QTime fileTime = QTime::fromString(baseName, "HH:mm:ss");

        // 检查 QTime 是否解析成功
        if (!fileTime.isValid()) {
            continue; // 跳过时间格式无效的文件
        }

        // 创建 QDateTime 对象，将当前日期与文件中的时间部分结合
        QDateTime fileDateTime(QDate::currentDate(), fileTime);

        // 比较与给定日期的日期部分
        if (fileDateTime.date() == date) {
            Schedule schedule = readFromFile(fileName);
            return schedule;
        }
    }
    // 处理未找到给定日期日程的情况
    Schedule emptySchedule; // 可以定义一个空的日程对象
    return emptySchedule;
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
