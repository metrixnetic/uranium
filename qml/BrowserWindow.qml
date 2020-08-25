// imports
import Qt.labs.settings 1.1
import QtQml 2.2
import QtQuick 2.2
import QtQuick.Controls 2.12 as Controls2
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0 as QQCPrivate
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtWebEngine 1.10

import QtQuick.Controls.Material 2.12

import QtUranium.Window 1.0

import "custom"

// Main window of browser
Window {
    id: browserWindow


    property QtObject applicationRoot
    property Item currentWebView: tabs.currentIndex < tabs.count ? tabs.getTab(tabs.currentIndex).item : null
    property int previousVisibility: Window.Windowed


    // for window movement
    property bool maximalized: false
    property point startMousePos
    property point startWindowPos
    property size startWindowSize

    function absoluteMousePos(mouseArea) {
        var windowAbs = mouseArea.mapToItem(null, mouseArea.mouseX, mouseArea.mouseY)
        return Qt.point(windowAbs.x + browserWindow.x,
                        windowAbs.y + browserWindow.y)
    }

    width: Screen.desktopAvailableWidth / 2
    height: Screen.desktopAvailableHeight / 2
    minimumWidth: 800
    minimumHeight: 600
    visible: true
    title: currentWebView && currentWebView.title

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowFullscreenButtonHint
    // Make sure the Qt.WindowFullscreenButtonHint is set on OS X.

    onCurrentWebViewChanged: {
        findBar.reset();
    }

    Material.theme: Material.Light
    Material.primary: Material.Grey
    Material.accent: Material.Blue

    // Create a styleItem to determine the platform.
    // When using style "mac", ToolButtons are not supposed to accept focus.
    QQCPrivate.StyleItem { id: styleItem }
    property bool platformIsMac: styleItem.style == "mac"

    Settings {
        id : appSettings
//        property alias autoLoadImages: loadImages.checked
//        property alias javaScriptEnabled: javaScriptEnabled.checked
//        property alias errorPageEnabled: errorPageEnabled.checked
//        property alias pluginsEnabled: pluginsEnabled.checked
//        property alias fullScreenSupportEnabled: fullScreenSupportEnabled.checked
//        property alias autoLoadIconsForPage: autoLoadIconsForPage.checked
//        property alias touchIconsEnabled: touchIconsEnabled.checked
//        property alias webRTCPublicInterfacesOnly : webRTCPublicInterfacesOnly.checked
//        property alias devToolsEnabled: devToolsEnabled.checked
//        property alias pdfViewerEnabled: pdfViewerEnabled.checked
    }

    Action {
        shortcut: "Ctrl+D"
        onTriggered: {
            downloadView.visible = !downloadView.visible;
        }
    }
    Action {
        id: focus
        shortcut: "Ctrl+L"
        onTriggered: {
            addressBar.forceActiveFocus();
            addressBar.selectAll();
        }
    }
    Action {
        shortcut: StandardKey.Refresh
        onTriggered: {
            if (currentWebView)
                currentWebView.reload();
        }
    }
    Action {
        shortcut: StandardKey.AddTab
        onTriggered: {
            tabs.createEmptyTab(tabs.count != 0 ? currentWebView.profile : defaultProfile);
            tabs.currentIndex = tabs.count - 1;
            addressBar.forceActiveFocus();
            addressBar.selectAll();
        }
    }
    Action {
        shortcut: StandardKey.Close
        onTriggered: {
            currentWebView.triggerWebAction(WebEngineView.RequestClose);
        }
    }
    Action {
        shortcut: "Escape"
        onTriggered: {
            if (currentWebView.state == "FullScreen") {
                browserWindow.visibility = browserWindow.previousVisibility;
                fullScreenNotification.hide();
                currentWebView.triggerWebAction(WebEngineView.ExitFullScreen);
            }

            if (findBar.visible)
                findBar.visible = false;
        }
    }
    Action {
        shortcut: "Ctrl+0"
        onTriggered: currentWebView.zoomFactor = 1.0
    }
    Action {
        shortcut: StandardKey.ZoomOut
        onTriggered: currentWebView.zoomFactor -= 0.1
    }
    Action {
        shortcut: StandardKey.ZoomIn
        onTriggered: currentWebView.zoomFactor += 0.1
    }

    Action {
        shortcut: StandardKey.Copy
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Copy)
    }
    Action {
        shortcut: "Ctrl+E"
        onTriggered: browserWindow.color = Universal.chromeBlackHighColor

    }
    Action {
        shortcut: StandardKey.Cut
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Cut)
    }
    Action {
        shortcut: StandardKey.Paste
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Paste)
    }
    Action {
        shortcut: "Shift+"+StandardKey.Paste
        onTriggered: currentWebView.triggerWebAction(WebEngineView.PasteAndMatchStyle)
    }
    Action {
        shortcut: StandardKey.SelectAll
        onTriggered: currentWebView.triggerWebAction(WebEngineView.SelectAll)
    }
    Action {
        shortcut: StandardKey.Undo
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Undo)
    }
    Action {
        shortcut: StandardKey.Redo
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Redo)
    }
    Action {
        shortcut: StandardKey.Back
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Back)
    }
    Action {
        shortcut: StandardKey.Forward
        onTriggered: currentWebView.triggerWebAction(WebEngineView.Forward)
    }
    Action {
        shortcut: StandardKey.Find
        onTriggered: {
            findBar.visible = !findBar.visible
        }
    }
    Action {
        shortcut: StandardKey.FindNext
        onTriggered: findBar.findNext()
    }
    Action {
        shortcut: StandardKey.FindPrevious
        onTriggered: findBar.findPrevious()
    }


    // TODO .|.

    // Declare properties that will store the position of the mouse cursor
//    property int previousX
//    property int previousY


//    // The central area for moving the application window
//    // Here you already need to use the position both along the X axis and the Y axis
//    MouseArea {
//        anchors {
//            top: parent.top
//            topMargin: 3
//            left: parent.left
//            leftMargin: 3
//            right: parent.right
//            rightMargin: 3
//        }

//        height: 35

//        onPressed: {
//            previousX = mouseX
//            previousY = mouseY
//        }

//        onMouseXChanged: {
//            var dx = mouseX - previousX
//            browserWindow.setX(browserWindow.x + dx)
//        }

//        onMouseYChanged: {
//            var dy = mouseY - previousY
//            browserWindow.setY(browserWindow.y + dy)
//        }
//    }


    FramelessHelper {
        id: framelessHelper

        titleBarHeight: 35

        Component.onCompleted: {
            addExcludeItem(tabs)
            addExcludeItem(controls)
        }
    }

    BrowserTabView{
        id: tabs
        onExcludesAdded: {
//            tas.getTab(0).item.children[0]
        }
    }

    BrowserTools{
        id: tools
        onGoForward: {
            currentWebView.goForward()
        }

        onGoBack: {
            currentWebView.goBack()
        }

        onStop: {
            currentWebView.stop()
        }

        onReload: {
            currentWebView.reload()
        }
        onShowDownloadList: {
            downloadView.visible = !downloadView.visible
        }
    }

    // Dev tools
    WebEngineView {
        id: devToolsView
        visible: false/*devToolsEnabled.checked*/
        height: visible ? 400 : 0
        inspectedView: visible && tabs.currentIndex < tabs.count ? tabs.getTab(tabs.currentIndex).item : null
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onNewViewRequested: function(request) {
            var tab = tabs.createEmptyTab(currentWebView.profile);
            tabs.currentIndex = tabs.count - 1;
            request.openIn(tab.item);
        }
    }



    FullScreenNotification {
        id: fullScreenNotification
    }

    DownloadView {
        id: downloadView
        visible: false
        anchors.fill: parent
    }

    function onDownloadRequested(download) {
        downloadView.visible = true;
        downloadView.append(download);
        download.accept();
    }

    FindBar {
        id: findBar
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top

        onFindNext: {
            if (text)
                currentWebView && currentWebView.findText(text);
            else if (!visible)
                visible = true;
        }
        onFindPrevious: {
            if (text)
                currentWebView && currentWebView.findText(text, WebEngineView.FindBackward);
            else if (!visible)
                visible = true;
        }
    }


    Rectangle {
        id: statusBubble
        color: "oldlace"
        property int padding: 8
        visible: false

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: statusText.paintedWidth + padding
        height: statusText.paintedHeight + padding

        Text {
            id: statusText
            anchors.centerIn: statusBubble
            elide: Qt.ElideMiddle

            Timer {
                id: hideStatusText
                interval: 750
                onTriggered: {
                    statusText.text = "";
                    statusBubble.visible = false;
                }
            }
        }
    }

    ThreeButtons{
        id: controls
        helper: framelessHelper
    }

//    // resizing window
//    CustomResizer{
//        anchors.fill: parent
//        size: 3
//    }

//    // TODO
//    Controls2.Button{
//        id: closeButton
//        icon.source: "../icons/close-24px.svg"
//        height: 35
//        width: height + 20
//        anchors.top: parent.top
//        anchors.right: parent.right
//        anchors.rightMargin: 5
//        highlighted: true
//        onClicked: {
//            Qt.quit()
//        }
//    }
}
