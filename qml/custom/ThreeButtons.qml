import QtQuick 2.0
import QtQuick.Window 2.3

Row {
    id: control

    property var helper
    property bool active: Window.active
    property bool noWarning: false
    property string color: "black"

    anchors {
        top: parent.top
        right: parent.right
        margins: 1
    }

    MinimizeButton {
        color: control.color
        onClicked: {helper.triggerMinimizeButtonAction()}
    }

    MaximizeButton {
        color: control.color
        onClicked: {helper.triggerMaximizeButtonAction()}
    }

    CloseButton {
        color: control.color
        onClicked: {helper.triggerCloseButtonAction()}
    }

    Component.onCompleted: {
        if (!noWarning){
            var arr = parent.children
            if (control !== arr[arr.length-1]) {
                console.log("Warning: ThreeButtons is not the last element!")
                console.log("Note: You can disable this warning by setting noWarning to true")
            }

        }
    }
}
