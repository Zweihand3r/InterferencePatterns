import QtQuick 2.7
import QtQuick.Controls 2.1

Dial {
    id: control

    property color handleColor: "#FFFFFF"
    property real liveValue: value

    onAngleChanged: setLiveValue()

    background: Rectangle {
        x: control.width / 2 - width / 2
        y: control.height / 2 - height / 2
        width: Math.max(64, Math.min(control.width, control.height))
        height: width
        color: "transparent"
        radius: width / 2
        border.color: "#FFFFFF"
        border.width: 2
        opacity: control.enabled ? 1 : 0.3
    }

    handle: Rectangle {
        id: handleItem
        x: control.background.x + control.background.width / 2 - width / 2
        y: control.background.y + control.background.height / 2 - height / 2
        width: 16
        height: 16
        color: control.hovered ? handleColor : "#FFFFFF"
        radius: 8
        antialiasing: true
        opacity: control.enabled ? 1 : 0.3
        transform: [
            Translate {
                y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height / 2
            },
            Rotation {
                angle: control.angle
                origin.x: handleItem.width / 2
                origin.y: handleItem.height / 2

                Behavior on angle {
                    enabled: !control.pressed
                    NumberAnimation { duration: 120 }
                }
            }
        ]

        Behavior on color { ColorAnimation { duration: 80 } }
    }

    function setLiveValue() {
        var angleValue = angle + 140
        liveValue = angleValue / 280
    }
}
