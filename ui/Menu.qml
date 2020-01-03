import QtQuick 2.0

Rectangle
{
    color: "#F1F1F1"

    Rectangle
    {
        id: currentTab
        width: window.width / 8
        height: menu.height
        color: "#C4C4C4"
        x: 10
        radius: 8

        Image
        {
            id: cross
            source: "crossT.svg"
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            anchors.right: parent.right
            width: 15
            height: 15
            y: 7.5
        }

    }

    Rectangle //fixing radius (on two side)
    {
        id: radiusFix
        width: currentTab.width
        height: 10
        color: "#C4C4C4"
        x: 10
        y: 20
    }
}
