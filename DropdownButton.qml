import QtQuick 2.7
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

ComboBox {
    id: control

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: modelData
            font.pixelSize: 17
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    indicator: Item {
        width: 23
        height: 17
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: control.popup.visible ? 0 : 2
        rotation: control.popup.visible ? 0 : 180
        Behavior on rotation { RotationAnimation { duration: 120 } }
        Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: 120 } }

        Rectangle { x: 9; y: 8; width: 16; height: 2; radius: 2; rotation: 45; color: "#FFFFFF" }
        Rectangle { x: -2; y: 8; width: 16; height: 2; radius: 2; rotation: -45; color: "#FFFFFF" }
    }

    contentItem: Text {
        text: control.displayText
        font.pixelSize: 17
        color: "#FFFFFF"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        rightPadding: 20
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

    popup: Popup {
        y: control.height - 2
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 0

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            interactive: false
        }

        background: Rectangle {
            anchors.fill: parent
            color: "#00000000"
            border.color: "#FFFFFF"
            border.width: 2

            Rectangle {
                anchors.fill: parent
                opacity: 0.9
            }
        }
    }
}
