#include "include/utils.h"

#ifndef QT_NO_WIDGETS
#include <QtWidgets/QApplication>
typedef QApplication Application;
#endif
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtWebEngine/qtwebengineglobal.h>

#include <QtQuickControls2/QQuickStyle>

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
    return QUrl(QStringLiteral("https://google.com"));
}

int main(int argc, char **argv)
{
    QCoreApplication::setOrganizationName("Metrixnetic");
    // qt.conf
    //    [Platforms]
    //    WindowsArguments = dpiawareness=0

    // попробуй, раскомментируй
//      qputenv("QT_SCALE_FACTOR", "2.0");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(
        Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
    //  Qt::Round
    //  Qt::Ceil
    //  Qt::Floor
    //  Qt::RoundPreferFloor
    //  Qt::PassThrough
    QtWebEngine::initialize();

    Application app(argc, argv);
//    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine appEngine;
    Utils utils;
    appEngine.rootContext()->setContextProperty("utils", &utils);
    appEngine.load(QUrl("qrc:/qml/ApplicationRoot.qml"));
    if (!appEngine.rootObjects().isEmpty())
        QMetaObject::invokeMethod(appEngine.rootObjects().first(), "load", Q_ARG(QVariant, startupUrl()));
    else
        qFatal("Failed to load sources");

    return app.exec();
}
