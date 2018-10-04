import QtQuick 2.7
import QtQuick.Controls 2.1

Slider {
    id: control
    value: 0.5

    property int liveValue: value

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 8
        width: control.availableWidth
        height: implicitHeight
        radius: 4
        color: "transparent"
        border.width: 2
        border.color: "#FFFFFF"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            radius: 4
            onWidthChanged: setLiveValue(width / (control.width - 12))
            Behavior on width { enabled: !control.pressed; NumberAnimation { duration: 120 } }
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 28
        implicitHeight: 28
        radius: 15

        Rectangle {
            id: hoverIndicator
            width: parent.width + 6
            height: parent.height + 6
            color: "#00000000"
            border.width: 2
            border.color: "#FFFFFF"
            radius: width / 2
            anchors.centerIn: parent
            opacity: control.hovered ? 1 : 0
            Behavior on opacity { OpacityAnimator { duration: 80 } }
        }

        Text {
            width: parent.width
            height: parent.height
            text: liveValue.toString()
            color: "#222222"
            font.pixelSize: text.length > 1 ? 15 : 17
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Behavior on x { enabled: !control.pressed; NumberAnimation { duration: 120 } }
    }

    function setLiveValue(percentValue) {
        liveValue = ((to - from) * percentValue) + from
    }
}
