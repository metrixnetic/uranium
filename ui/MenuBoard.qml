import QtQuick 2.4

GridView
{
    id: root
    model: 1

    cellWidth: width / 7.7

    delegate: Menu
    {
        width: cellWidth
    }
}
