#include "MouseTracker.h"
#include <QDebug>

MouseTracker::MouseTracker(QObject *parent)
    : QObject(parent)
{}

void MouseTracker::trackMouseClick(int x, int y)
{
    m_lastMousePos.setX(x);
    m_lastMousePos.setY(y);

    emit mousePositionChanged(m_lastMousePos.x(), m_lastMousePos.y());
}
