import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: window
    flags: Qt.FramelessWindowHint |
         Qt.WindowMinimizeButtonHint |
         Qt.Window
    x: 0
    y: 0
    width: Screen.width
    height: Screen.height
    minimumWidth: 500
    minimumHeight: 500
    visible: true

    Menu
    {
        id: menu
        width: window.width
        height: 30
    }

    MenuBoard
    {
        anchors.fill: parent
    }

    Search
    {
        id: search
        width: window.width
        height: 30
    }

}
