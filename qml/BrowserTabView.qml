import QtQml 2.2
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0 as QQCPrivate
import QtQuick.Controls.Styles 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import QtWebEngine 1.10

TabView {
    id: tabs
//    width: browserWindow.width * 0.8
    clip: false
    function createEmptyTab(profile) {
        var tab = addTab("new tab", tabComponent);
        // We must do this first to make sure that tab.active gets set so that tab.item gets instantiated immediately.
        tab.active = true;
        tab.title = Qt.binding(function() { return tab.item.title });
        tab.item.profile = profile;
        return tab;

    }
    anchors {
        top: parent.top
        bottom: devToolsView.bottom
        bottomMargin: 35
        left: parent.left
        right: parent.right
    }
    Component.onCompleted: {createEmptyTab(defaultProfile)}


    // Add custom tab view style so we can customize the tabs to include a close button
    style: TabViewStyle {
        id: whiteTabs
        property color frameColor: "#999"
        property color fillColor: "#eee"
        property color nonSelectedColor: "#ddd"
        frameOverlap: 1
        tabsMovable: true
        frame: Rectangle {
            color: "#fff"
            border.color: frameColor
        }

        tab: Rectangle {
            id: tabRectangle
            width: 200
            height: 35
            color: styleData.selected ? '#C4C4C4' : '#DDDDDD'
            radius: 5
            clip: true
            anchors.top: parent.top

            implicitWidth: 200
            implicitHeight: Math.max(text.height + 10, 20)

            Text {
                id: text
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: 15
                anchors.leftMargin: 26
                anchors.topMargin: 26
                text: styleData.title
                elide: Text.ElideRight
                color: styleData.selected ? "black" : frameColor
            }
            Button {
                id: btnRemoveTab
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 1
                height: 12
                iconSource: "../icons/close-24px.svg"
                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 30
                        implicitHeight: 35
                        color: btnRemoveTab.hovered ? "#ccc" : tabRectangle.color

                    }}
                onClicked: tabs.removeTab(styleData.index);
            }

            Button {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                height: 15
                iconSource: "../icons/add-black-18dp.svg"
                style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 10
                        implicitHeight: 10
                        color: control.hovered ? "#ccc" : tabRectangle.color
                    }}
                onClicked: tabs.createEmptyTab(defaultProfile);
            }

        }
    }

    //Web content of browser
    Component {
        id: tabComponent
        WebEngineView {
            id: webEngineView
            focus: true
            width: browserWindow.__width
            anchors {
                top: parent.top
                topMargin: 42
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            onLinkHovered: function(hoveredUrl) {
                if (hoveredUrl === "")
                    hideStatusText.start();
                else {
                    statusText.text = hoveredUrl;
                    statusBubble.visible = true;
                    hideStatusText.stop();
                }
            }

            states: [
                State {
                    name: "FullScreen"
                    PropertyChanges {
                        target: tabs
                        frameVisible: false
                        tabsVisible: false
                    }
                    PropertyChanges {
                        target: navigationBar
                        visible: false
                    }
                }
            ]

            onCertificateError: function(error) {
                error.defer();
            }

            onNewViewRequested: function(request) {
                if (!request.userInitiated)
                    print("Warning: Blocked a popup window.");
                else if (request.destination === WebEngineView.NewViewInTab) {
                    var tab = tabs.createEmptyTab(currentWebView.profile);
                    tabs.currentIndex = tabs.count - 1;
                    request.openIn(tab.item);
                } else if (request.destination === WebEngineView.NewViewInBackgroundTab) {
                    var backgroundTab = tabs.createEmptyTab(currentWebView.profile);
                    request.openIn(backgroundTab.item);
                } else if (request.destination === WebEngineView.NewViewInDialog) {
                    var dialog = applicationRoot.createDialog(currentWebView.profile);
                    request.openIn(dialog.currentWebView);
                } else {
                    var window = applicationRoot.createWindow(currentWebView.profile);
                    request.openIn(window.currentWebView);
                }
            }

            onFullScreenRequested: function(request) {
                if (request.toggleOn) {
                    webEngineView.state = "FullScreen";
                    browserWindow.previousVisibility = browserWindow.visibility;
                    browserWindow.showFullScreen();
                    fullScreenNotification.show();
                } else {
                    webEngineView.state = "";
                    browserWindow.visibility = browserWindow.previousVisibility;
                    fullScreenNotification.hide();
                }
                request.accept();
            }

            onQuotaRequested: function(request) {
                if (request.requestedSize <= 5 * 1024 * 1024)
                    request.accept();
                else
                    request.reject();
            }

            onRegisterProtocolHandlerRequested: function(request) {
                console.log("accepting registerProtocolHandler request for "
                            + request.scheme + " from " + request.origin);
                request.accept();
            }

            // If smth crash
            onRenderProcessTerminated: function(terminationStatus, exitCode) {
                var status = "";
                switch (terminationStatus) {
                case WebEngineView.NormalTerminationStatus:
                    status = "(normal exit)";
                    break;
                case WebEngineView.AbnormalTerminationStatus:
                    status = "(abnormal exit)";
                    break;
                case WebEngineView.CrashedTerminationStatus:
                    status = "(crashed)";
                    break;
                case WebEngineView.KilledTerminationStatus:
                    status = "(killed)";
                    break;
                }

                print("Render process exited with code " + exitCode + " " + status);
                reloadTimer.running = true;
            }

            onWindowCloseRequested: {
                if (tabs.count == 1)
                    browserWindow.close();
                else
                    tabs.removeTab(tabs.currentIndex);
            }

            onSelectClientCertificate: function(selection) {
                selection.certificates[0].select();
            }

            onFindTextFinished: function(result) {
                if (!findBar.visible)
                    findBar.visible = true;

                findBar.numberOfMatches = result.numberOfMatches;
                findBar.activeMatch = result.activeMatch;
            }

            onLoadingChanged: function(loadRequest) {
                if (loadRequest.status == WebEngineView.LoadStartedStatus)
                    findBar.reset();
            }

            Timer {
                id: reloadTimer
                interval: 0
                running: false
                repeat: false
                onTriggered: currentWebView.reload()
            }
        }
    }
}
