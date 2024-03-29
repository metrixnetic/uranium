
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Rectangle {
    id: root

    property int numberOfMatches: 0
    property int activeMatch: 0
    property alias text: findTextField.text

    function reset() {
        numberOfMatches = 0;
        activeMatch = 0;
        visible = false;
    }

    signal findNext()
    signal findPrevious()

    width: 250
    height: 35
    radius: 2

    border.width: 1
    border.color: "black"
    color: "white"

    onVisibleChanged: {
        if (visible)
            findTextField.forceActiveFocus();
    }


    RowLayout {
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        spacing: 5

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TextField {
                id: findTextField
                anchors.fill: parent

                style: TextFieldStyle {
                    background: Rectangle {
                        color: "transparent"
                    }
                }

                onAccepted: root.findNext()
                onTextChanged: root.findNext()
                onActiveFocusChanged: activeFocus ? selectAll() : deselect()
            }
        }

        Label {
            text: activeMatch + "/" + numberOfMatches
            visible: findTextField.text != ""
        }

        Rectangle {
            border.width: 1
            border.color: "#ddd"
            width: 2
            height: parent.height
            anchors.topMargin: 5
            anchors.bottomMargin: 5
        }

        ToolButton {
            text: "<"
            enabled: numberOfMatches > 0
            onClicked: root.findPrevious()
        }

        ToolButton {
            text: ">"
            enabled: numberOfMatches > 0
            onClicked: root.findNext()
        }

        ToolButton {
            text: "x"
            onClicked: root.visible = false
        }
    }
}
