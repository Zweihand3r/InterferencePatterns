#ifndef CPPHELPERS_H
#define CPPHELPERS_H

#include <QObject>
#include <QColor>

class CppHelpers : public QObject
{
    Q_OBJECT

public:
    explicit CppHelpers(QObject *parent = nullptr);

    Q_INVOKABLE int getRed(const QString &colorStr);
    Q_INVOKABLE int getGreen(const QString &colorStr);
    Q_INVOKABLE int getBlue(const QString &colorStr);

signals:

public slots:
};

#endif // CPPHELPERS_H
