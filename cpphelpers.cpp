#include "cpphelpers.h"

CppHelpers::CppHelpers(QObject *parent) : QObject(parent)
{

}

int CppHelpers::getRed(const QString &colorStr)
{
    QColor *color = new QColor(colorStr);
    return color->red();
}

int CppHelpers::getGreen(const QString &colorStr)
{
    QColor *color = new QColor(colorStr);
    return color->green();
}

int CppHelpers::getBlue(const QString &colorStr)
{
    QColor *color = new QColor(colorStr);
    return color->blue();
}
