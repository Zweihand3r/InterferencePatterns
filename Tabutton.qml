import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

TabButton {
    id: control
    height: 36
    text: "Tabutton"

    property real margin: 4

    contentItem: Text {
        text: control.text
        font.pixelSize: 19
        color: checked ? "#222222" : "#FFFFFF"
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

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: margin
            anchors.leftMargin: margin
            anchors.rightMargin: margin
            anchors.bottomMargin: margin
            color: checked ? "#FFFFFF" : "#00000000"
            Behavior on color { ColorAnimation { duration: 120 } }
        }
    }
}
