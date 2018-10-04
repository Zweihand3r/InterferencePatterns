#ifndef SHAPE_H
#define SHAPE_H

#include <QObject>
#include <QQmlEngine>

class Shape : public QObject {
    Q_OBJECT

public :
    Shape() : QObject() {}

    enum Shapes {
        Circle,
        Square,
        Diamond
    };
    Q_ENUMS(Shapes)
};

#endif // SHAPE_H
