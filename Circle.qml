import QtQuick 2.7

import Shape 1.0

Item {
    id: rootCircle
    width: leCircle.width
    height: leCircle.height
    anchors.centerIn: parent
    rotation: shape === Shape.Diamond ? 45 : 0
    clip: true

    property color leColor: "black"
    property int borderWidth: 8
    property int endDiameter: 2500
    property int speed: 3
    property bool reversed: false

    property int shape: Shape.Circle

    Rectangle {
        id: leCircle
        width: 0
        height: 0
        radius: shape === Shape.Circle ? width / 2 : 0
        color: "transparent"
        border.width: borderWidth
        border.color: leColor
        anchors.centerIn: parent
    }

    NumberAnimation {
        id: circleGrowthAnim
        targets: [leCircle]
        properties: "width, height"
        from: reversed ? endDiameter : 0
        to: reversed ? 0 : endDiameter
        running: true
        duration: getAnimDuration()
        onStopped: rootCircle.destroy()
    }

    function getAnimDuration() {
        switch (speed) {
        case 1: return 40000
        case 2: return 20000
        case 3: return 10000
        case 4: return 5000
        case 5: return 2500
        }
    }
}
