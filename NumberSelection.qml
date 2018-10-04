import QtQuick 2.7

Item {
    id: control
    width: 64
    height: 36

    property int count: 10
    property int currentCount: 1

    Label_ {
        text: currentCount.toString()
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: controls.opacity = 1
        onExited: controls.opacity = 0
    }

    Item {
        id: controls
        anchors.fill: parent
        opacity: 0
        Behavior on opacity { OpacityAnimator { duration: 120 } }

        Item {
            width: 17
            height: 23
            anchors.top: parent.top
            anchors.topMargin: -16
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: -90

            Rectangle {
                y: 4; width: 16; height: 4; radius: 2; rotation: 45
                color: currentCount < count ? "#FFFFFF" : "#696969"
                Behavior on color { ColorAnimation { duration: 80 } }
            }

            Rectangle {
                y: 14; width: 16; height: 4; radius: 2; rotation: -45
                color: currentCount < count ? "#FFFFFF" : "#696969"
                Behavior on color { ColorAnimation { duration: 80 } }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: controls.handleControlsHover(parent, true)
                onExited: controls.handleControlsHover(parent, false)
                onClicked: controls.handleCurrentCount(true)
            }
        }

        Item {
            width: 17
            height: 23
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -16
            anchors.horizontalCenter: parent.horizontalCenter
            rotation: 90

            Rectangle {
                y: 4; width: 16; height: 4; radius: 2; rotation: 45
                color: currentCount > 1 ? "#FFFFFF" : "#696969"
                Behavior on color { ColorAnimation { duration: 80 } }
            }

            Rectangle {
                y: 14; width: 16; height: 4; radius: 2; rotation: -45
                color: currentCount > 1 ? "#FFFFFF" : "#696969"
                Behavior on color { ColorAnimation { duration: 80 } }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: controls.handleControlsHover(parent, true)
                onExited: controls.handleControlsHover(parent, false)
                onClicked: controls.handleCurrentCount(false)
            }
        }

        function handleCurrentCount(incremented) {
            if (incremented) {
                if (currentCount < count) {
                    currentCount++
                }
            }
            else {
                if (currentCount > 1) {
                    currentCount--
                }
            }
        }

        function handleControlsHover(parent, hovered) {
            controls.opacity = hovered ? 1 : 0
            parent.scale = hovered ? 1.2 : 1
        }
    }
}
