# TODO:
# 1. Увеличить поисквую строку и таб
# 2. Title в табе заваливается на поисковый бар
# 3. web engine вылзаит за рамки
# 4. добавить иконки и улучшить дизайн менюшки с функциями

requires(qtConfig(accessibility))

TEMPLATE = app
TARGET = Uranium

HEADERS = include\utils.h
SOURCES = main.cpp \
#          src/cookiejar.cpp

OTHER_FILES += qml\ApplicationRoot.qml \
               qml\BrowserDialog.qml \
               qml\BrowserWindow.qml \
               qml\DownloadView.qml \
               qml\FindBar.qml \
               qml\FullScreenNotification.qml


RESOURCES += resources.qrc \

QT += qml quick webengine

qtHaveModule(widgets) {
    QT += widgets
}

INSTALLS += target

FORMS += \
    forms\cookiedialog.ui \
    forms\cookiewidget.ui