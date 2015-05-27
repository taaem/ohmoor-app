#include <QApplication>
#include <QtQml>
#include <QQmlApplicationEngine>
#include "requestplan.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<RequestPlan>("com.taaem.vertretungsplan", 1, 0, "Vertretungsplan");
    app.setOrganizationName("taaem");
    app.setOrganizationDomain("taaem.github.io");
    app.setApplicationName("Vertretungsplan");

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
