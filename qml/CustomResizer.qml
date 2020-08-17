import QtQuick 2.14

Item {
    id: frame
    property Item content
    property int size
    MouseArea {
        enabled: !browserWindow.maximalized
        id: resizeTopRight
        anchors{
            top: parent.top
            right: parent.right
        }
        height: size
        width: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeBDiagCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowPos = Qt.point(browserWindow.x, browserWindow.y)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseXChanged:{
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newWidth = Math.max(browserWindow.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
                browserWindow.setGeometry(browserWindow.x, browserWindow.y, newWidth, browserWindow.height)
            }
        }
        onMouseYChanged: {
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newHeigh = Math.max(browserWindow.minimumHeight, startWindowSize.height - (abs.y - startMousePos.y))
                var newY = startWindowPos.y - (newHeigh - startWindowSize.height)
                browserWindow.setGeometry(browserWindow.x, newY, browserWindow.width, newHeigh)
            }
        }
    }

    MouseArea {
        id: resizeTopLeft
        enabled: !browserWindow.maximalized
        anchors{
            top: parent.top
            left: parent.left
        }
        height: size
        width: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeFDiagCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowPos = Qt.point(browserWindow.x, browserWindow.y)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseXChanged:{
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newWidth = Math.max(browserWindow.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
                var newX = startWindowPos.x - (newWidth - startWindowSize.width)
                browserWindow.setGeometry(newX, browserWindow.y, newWidth, browserWindow.height)
            }
        }
        onMouseYChanged: {
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newHeigh = Math.max(browserWindow.minimumHeight, startWindowSize.height - (abs.y - startMousePos.y))
                var newY = startWindowPos.y - (newHeigh - startWindowSize.height)
                browserWindow.setGeometry(browserWindow.x, newY, browserWindow.width, newHeigh)
            }
        }
    }

    MouseArea {
        id: resizeTop
        enabled: !browserWindow.maximalized
        anchors{
            top: parent.top
            right: resizeTopRight.left
            left: resizeTopLeft.right
        }
        height: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeVerCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowPos = Qt.point(browserWindow.x, browserWindow.y)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseYChanged: {
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newHeigh = Math.max(browserWindow.minimumHeight, startWindowSize.height - (abs.y - startMousePos.y))
                var newY = startWindowPos.y - (newHeigh - startWindowSize.height)
                browserWindow.setGeometry(browserWindow.x, newY, browserWindow.width, newHeigh)
            }
        }
    }

    MouseArea {
        id: resizeLeft
        enabled: !browserWindow.maximalized
        anchors{
            top: resizeTopLeft.bottom
            left: parent.left
            bottom: resizeBottomLeft.top
        }
        width: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeHorCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowPos = Qt.point(browserWindow.x, browserWindow.y)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseXChanged:{
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newWidth = Math.max(browserWindow.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
                var newX = startWindowPos.x - (newWidth - startWindowSize.width)
                browserWindow.setGeometry(newX, browserWindow.y, newWidth, browserWindow.height)
            }
        }
    }

    MouseArea {
        id: resizeBottomLeft
        enabled: !browserWindow.maximalized
        anchors{
            bottom: parent.bottom
            left: parent.left
        }
        height: size
        width: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeBDiagCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowPos = Qt.point(browserWindow.x, browserWindow.y)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseXChanged:{
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newWidth = Math.max(browserWindow.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
                var newX = startWindowPos.x - (newWidth - startWindowSize.width)
                browserWindow.setGeometry(newX, browserWindow.y, newWidth, browserWindow.height)
            }
        }
        onMouseYChanged: {
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newHeigh = Math.max(browserWindow.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
                browserWindow.setGeometry(browserWindow.x, browserWindow.y, browserWindow.width, newHeigh)
            }
        }
    }

    MouseArea {
        id: resizeBottom
        enabled: !browserWindow.maximalized
        anchors{
            left: resizeBottomLeft.right
            bottom: parent.bottom
            right: resizeBottomRight.left
        }
        height: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeVerCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseYChanged: {
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newHeigh = Math.max(browserWindow.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
                browserWindow.setGeometry(browserWindow.x, browserWindow.y, browserWindow.width, newHeigh)
            }
        }
    }

    MouseArea {
        id: resizeBottomRight
        enabled: !browserWindow.maximalized
        anchors{
            bottom: parent.bottom
            right: parent.right
        }
        height: size
        width: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeFDiagCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseXChanged:{
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newWidth = Math.max(browserWindow.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
                browserWindow.setGeometry(browserWindow.x, browserWindow.y, newWidth, browserWindow.height)
            }
        }
        onMouseYChanged: {
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newHeigh = Math.max(browserWindow.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
                browserWindow.setGeometry(browserWindow.x, browserWindow.y, browserWindow.width, newHeigh)
            }
        }
    }

    MouseArea {
        id: resizeRight
        enabled: !browserWindow.maximalized
        anchors{
            top: resizeTopRight.bottom
            right: parent.right
            bottom: resizeBottomRight.top
        }
        width: size
        hoverEnabled: true
        onHoveredChanged: cursorShape = (!browserWindow.maximalized && (containsMouse || pressed) ?  Qt.SizeHorCursor :  Qt.ArrowCursor)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowSize = Qt.size(browserWindow.width, browserWindow.height)
        }
        onMouseXChanged:{
            if(pressed && !browserWindow.maximalized) {
                var abs = absoluteMousePos(this)
                var newWidth = Math.max(browserWindow.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
                browserWindow.setGeometry(browserWindow.x, browserWindow.y, newWidth, browserWindow.height)
            }
        }
    }
}
