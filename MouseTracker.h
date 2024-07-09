#ifndef MOUSETRACKER_HPP
#define MOUSETRACKER_HPP

#include <QObject>
#include <QPointF>

class MouseTracker : public QObject
{
    Q_OBJECT
public:
    explicit MouseTracker(QObject *parent = nullptr);

signals:
    void mousePositionChanged(qreal x, qreal y);

public slots:
    void trackMouseClick(int x, int y);

private:
    QPointF m_lastMousePos;
};

#endif // MOUSETRACKER_HPP
