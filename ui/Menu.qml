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
            source: "file:/home/mylove/web-work/20-uranium/Idx_Uranium/img/cross.svg"
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
