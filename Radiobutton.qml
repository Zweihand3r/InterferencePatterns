import QtQuick 2.7

Item {
    id: control
    width: 36
    height: 36

    property bool selected: false

    Rectangle {
        id: frame
        width: 36
        height: 36
        radius: 18
        anchors.centerIn: parent
        color: "#00000000"
        border.width: 2
        border.color: "#FFFFFF"
        Behavior on scale { ScaleAnimator { duration: 80 } }
    }

    Rectangle {
        id: indicator
        width: 24
        height: 24
        radius: 12
        anchors.centerIn: parent
        scale: selected ? 1 : 0
        Behavior on scale { ScaleAnimator { duration: 80 } }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: selected = !selected
        onEntered: frame.scale = 1.1
        onExited: frame.scale = 1
    }
}
