import QtQuick 2.7
import QtGraphicalEffects 1.0

import Shape 1.0

Item {
    id: rootCS
    width: 64
    height: 64

    property color leColor: "#FFFFFF"
    property int endDiameter: 128
    property bool selected: true

    property int shape: Shape.Circle
    property bool reversed: false

    onReversedChanged: reverseChangeHandler()

    Rectangle {
        id: leCircleUnselected
        width: 32
        height: 32
        radius: shape === Shape.Circle ? width / 2 : 0
        rotation: shape === Shape.Diamond ? 45 : 0
        color: "transparent"
        border.width: 4
        border.color: leColor
        anchors.centerIn: parent
        opacity: selected ? 0 : 1
        Behavior on opacity { OpacityAnimator { duration: 120 } }
    }

    Item {
        id: circleContainer
        width: 32
        height: 32
        opacity: selected ? 1 : 0
        anchors.centerIn: parent
        Behavior on opacity { OpacityAnimator { duration: 120 } }

        Rectangle {
            id: leCircle
            width: 32
            height: 32
            radius: shape === Shape.Circle ? width / 2 : 0
            rotation: shape === Shape.Diamond ? 45 : 0
            color: "transparent"
            border.width: 4
            border.color: leColor
            anchors.centerIn: parent
        }
    }

    RadialGradient {
        id: hoverIndicator
        anchors.fill: parent
        opacity: 0
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(leColor.r, leColor.g, leColor.b, 0.5) }
            GradientStop {
                position: clicky.pressed ? 0.125 : 0.2; color: Qt.rgba(leColor.r, leColor.g, leColor.b, 0.5)
                Behavior on position { NumberAnimation { duration: 80 } }
            }

            GradientStop {
                position: clicky.pressed ? 0.4 : 0.5; color: "transparent"
                Behavior on position { NumberAnimation { duration: 80 } }
            }
        }

        Behavior on opacity { OpacityAnimator { duration: 120 } }
    }

    MouseArea {
        id: clicky
        anchors.fill: parent
        hoverEnabled: true
        onClicked: selected = !selected
        onEntered: hoverIndicator.opacity = 1
        onExited: hoverIndicator.opacity = 0
    }

    ParallelAnimation {
        id: circleGrowthAnim
        loops: Animation.Infinite
        running: true

        NumberAnimation {
            targets: [leCircle]
            properties: "width, height"
            from: reversed ? endDiameter : 32
            to: reversed ? 32 : endDiameter
            duration: 720
        }

        OpacityAnimator {
            target: leCircle
            from: 1
            to: 0
            duration: 720
            easing.type: Easing.InQuint
        }
    }

    Timer {
        id: reverseTimer
        interval: 10; repeat: false; running: false
        onTriggered: circleGrowthAnim.start()
    }

    function reverseChangeHandler() {
        circleGrowthAnim.stop()
        reverseTimer.start()
    }
}
