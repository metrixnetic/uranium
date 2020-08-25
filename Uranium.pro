requires(qtConfig(accessibility))

TEMPLATE = app
TARGET = Uranium

HEADERS = include\utils.h
SOURCES = main.cpp \
#          src/cookiejar.cpp

include(FramelessHelper/FramelessHelper.pri)

OTHER_FILES += qml\ApplicationRoot.qml \
               qml\BrowserWindow.qml \
               qml\DownloadView.qml \
               qml\FindBar.qml \
               qml\FullScreenNotification.qml \
               qml\BrowserTabView.qml \
               qml\CustomResizer.qml \


RESOURCES += resources.qrc \

QT += qml quick webengine quickcontrols2

qtHaveModule(widgets) {
    QT += widgets
}

INSTALLS += target

DISTFILES += \
    qml/BrowserTools.qml \
    qml/History.qml


DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000
