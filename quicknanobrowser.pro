requires(qtConfig(accessibility))

TEMPLATE = app
TARGET = quicknanobrowser

HEADERS = utils.h
SOURCES = main.cpp

OTHER_FILES += ApplicationRoot.qml \
               BrowserDialog.qml \
               BrowserWindow.qml \
               DownloadView.qml \
               FindBar.qml \
               FullScreenNotification.qml

RESOURCES += resources.qrc

QT += qml quick webengine

qtHaveModule(widgets) {
    QT += widgets
}

INSTALLS += target
