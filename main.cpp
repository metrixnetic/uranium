#include "utils.h"

#ifndef QT_NO_WIDGETS
#include <QtWidgets/QApplication>
typedef QApplication Application;
#endif
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtWebEngine/qtwebengineglobal.h>

static QUrl startupUrl()
{
    QUrl ret;
    QStringList args(qApp->arguments());
    args.takeFirst();
    for (const QString &arg : qAsConst(args)) {
        if (arg.startsWith(QLatin1Char('-')))
             continue;
        ret = Utils::fromUserInput(arg);
        if (ret.isValid())
            return ret;
    }
    return QUrl(QStringLiteral("https:/google.com"));
}

int main(int argc, char **argv)
{
    QCoreApplication::setOrganizationName("QtExamples");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QtWebEngine::initialize();

    Application app(argc, argv);

    QQmlApplicationEngine appEngine;
    Utils utils;
    appEngine.rootContext()->setContextProperty("utils", &utils);
    appEngine.load(QUrl("qrc:/ApplicationRoot.qml"));
    if (!appEngine.rootObjects().isEmpty())
        QMetaObject::invokeMethod(appEngine.rootObjects().first(), "load", Q_ARG(QVariant, startupUrl()));
    else
        qFatal("Failed to load sources");

    return app.exec();
}
