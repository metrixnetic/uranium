import QtQuick 2.7

Rectangle
{
    color: "#C4C4C4"
    y: 30

    Row
    {
        spacing: 10

        Image
        {
            id: leftArrow
            source: "leftArrow.svg"
            y: 1
        }

        Image
        {
            id: rightArrow
            source: "rightArrow.svg"
            y: 1
        }

        Image
        {
            id: reload
            source: "reload.svg"
            y: 3.5
        }

        Rectangle
        {
            color: "white"
            height: 24
            width: window.width / 2
            radius: 20
            y: 3
        }

        Rectangle
        {
            color: "white"
            width: 24
            height: 24
            radius: 100
        }


    }

}
