requires(qtConfig(accessibility))

TEMPLATE = app
TARGET = Uranium

HEADERS += include/utils.h \

SOURCES += main.cpp \

OTHER_FILES +=  qml/ApplicationRoot.qml \
				qml/BrowserWindow.qml \
				qml/DownloadView.qml \
				qml/FindBar.qml \
				qml/FullScreenNotification.qml \
				qml/BrowserTabView.qml \
				qml/CustomResizer.qml \
				qml/BrowserTools.qml \
				qml/History.qml


RESOURCES += resources.qrc

QT += qml quick webengine quickcontrols2

qtHaveModule(widgets) {
    QT += widgets
}

INSTALLS += target