#pragma once

#include <QDate>
#include <QList>
#include <QObject>
#include <QString>
#include <QTime>
#include <QVector>

struct Schedule
{
    QString eventName;
    QDate eventDate;
    QTime startTime;
    QTime endTime;
    QTime reminderTime;
};

class FileManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString storagePath READ storagePath WRITE setStoragePath NOTIFY storagePathChanged)

public:
    explicit FileManager(QObject* parent = nullptr);
    Q_INVOKABLE bool isValidDate(const QDate& date) const;
    Q_INVOKABLE bool hasSchedule(const QDate& date) const;
    Q_INVOKABLE QVariantList getAllSchedulesAsVariantList();
    Q_INVOKABLE QList<Schedule> getAllSchedules();
    Q_INVOKABLE QList<Schedule> getSchedule(const QDate& date) const;
    Q_INVOKABLE QVariantList getSchedulesAsVariantList(const QDate& date) const;
    Q_INVOKABLE void addOrUpdateSchedule(const QDate& date,
                                         const QTime& time,
                                         const Schedule& schedule);
    Q_INVOKABLE void removeSchedule(const QDate& date, const QTime& time);
    Q_INVOKABLE Schedule setSchedule(const QString& eventName,
                                     const QDate& eventDate,
                                     const QTime& startTime,
                                     const QTime& endTime,
                                     const QTime& reminderTime) const;

    QString storagePath() const;
    void setStoragePath(const QString& path);

signals:
    void storagePathChanged();

private:
    QString generateFileName(const QDate& date) const;
    QString generateFileName(const QDate& date, const QTime& time) const;

    void saveToFile(const QString& fileName,
                    const QDate& date,
                    const QTime& time,
                    const QString& data) const;

    Schedule readFromFile(const QString& fileName) const;
    QString serializeSchedule(const Schedule& schedule) const;
    Schedule deserializeSchedule(const QString& data) const;

    QString m_storagePath;
    QList<Schedule> allSchedules; // 存储所有日程的列表
};
