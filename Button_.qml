import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Button {
    id: control
    width: 128
    height: 36
    text: "Button"
    scale: control.down ? 0.94 : 1
    Behavior on scale { ScaleAnimator { duration: 80 } }

    contentItem: Text {
        text: control.text
        font: control.font
        color: "#FFFFFF"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        anchors.fill: parent
        color: "#00000000"
        border.color: "#FFFFFF"
        border.width: 2

        RadialGradient {
            anchors.fill: parent
            horizontalRadius: control.width
            verticalRadius: control.height
            opacity: hovered ? 1 : 0
            Behavior on opacity { OpacityAnimator { duration: 80 } }

            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.5) }
            }
        }
    }
}
