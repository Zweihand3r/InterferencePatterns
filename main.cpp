#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "cpphelpers.h"
#include "shape.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<CppHelpers>("CppHelpers", 1, 0, "CppHelpers");
    qmlRegisterType<Shape>("Shape", 1, 0, "Shape");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
