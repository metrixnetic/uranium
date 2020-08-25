import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


ToolBar {
    id: root

    signal goBack()
    signal goForward()
    signal stop()
    signal reload()
    signal showDownloadList()

    implicitWidth: parent.width
    implicitHeight: 45

    anchors {
        top: parent.top
        topMargin: 35
        left: parent.left
        right: parent.right
    }

    RowLayout {
        anchors.fill: parent

        ToolButton {
            id: backButton
            icon.source: "../icons/arrow_back_ios-24px.svg"

            enabled: currentWebView && currentWebView.canGoBack
            activeFocusOnTab: !root.parent.platformIsMac
            Layout.bottomMargin: 60
            anchors.verticalCenter: ToolButton.verticalCenter;

            onClicked: goBack()

        }   // Back button

        ToolButton {
            id: forwardButton
            icon.source: "../icons/arrow_forward_ios-24px.svg"
            enabled: currentWebView && currentWebView.canGoForward
            activeFocusOnTab: !root.parent.platformIsMac
            Layout.bottomMargin: 60
            anchors.verticalCenter: ToolButton.verticalCenter;

            onClicked: goForward()

        }   // Forward button

        ToolButton {
            id: reloadButton
            icon.source: currentWebView && currentWebView.loading ? "../icons/close-24px.svg" : "../icons/refresh-24px.svg"
            activeFocusOnTab: !root.parent.platformIsMac
            Layout.bottomMargin: 60
            anchors.verticalCenter: ToolButton.verticalCenter

            onClicked: currentWebView && currentWebView.loading ? stop() : reload()

        }

        TextField {
            id: addressBar

            leftPadding: 35
            background: Rectangle{
                radius: 20
                border.color: "#ffffff"
                border.width: 1
                color: "transparent"
            }

            Layout.bottomMargin: 65
            focus: true
            Layout.fillWidth: true
            selectByMouse: true
            font.pointSize: 12
            verticalAlignment: TextField.AlignVCenter
            text: currentWebView && currentWebView.url
            onAccepted: {
                currentWebView.url = utils.fromUserInput(text)
            }

            Image {
                id: pageIcon
                x: 10
                y: 7
                z: 2
                width: 18; height: 18
                sourceSize: Qt.size(width, height)
                source: currentWebView && currentWebView.icon
            }   // current page icon


        }   // address field


        ToolButton {
            id: downloadList

            Layout.bottomMargin: 60
            anchors.verticalCenter: ToolButton.verticalCenter

            icon.source: "../icons/get_app-black-18dp.svg"

            onClicked: showDownloadList()
        }



    }   // Row
    ProgressBar {
        id: pageLoadingProgress
        height: 4
        z: -2
        anchors{
            left: parent.left
            top: parent.bottom
            right: parent.right
        }

        background: Rectangle {
            implicitWidth: root.width
            implicitHeight: 4
            color: "#e6e6e6"
            radius: 3
        }
        contentItem: Item {
            implicitWidth: root.width
            implicitHeight: 2

            Rectangle {
                width: pageLoadingProgress.visualPosition * parent.width
                height: parent.height
                radius: 2
                color: "#17a81a"
            }
        }
        value: (currentWebView && currentWebView.loadProgress < 100) ? currentWebView.loadProgress : 0
    }
}
