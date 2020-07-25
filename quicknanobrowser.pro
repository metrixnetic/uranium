# TODO:
# 1. Увеличить поисквую строку и таб
# 2. Title в табе заваливается на поисковый бар
# 3. web engine вылзаит за рамки
# 4. добавить иконки и улучшить дизайн менюшки с функциями

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


RESOURCES += resources.qrc \

QT += qml quick webengine

qtHaveModule(widgets) {
    QT += widgets
}

INSTALLS += target

FORMS += \
    cookiedialog.ui \
    cookiewidget.ui
