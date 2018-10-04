import QtQuick 2.0

Item {
    id: rootPS
    width: 48
    height: 48
    scale: 0.8

//    DebugBackground {}

    property bool playMode: true

    Item {
        id: content
        width: 32
        height: 32
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 2

        Rectangle { id: line1; x: -1; y: 7; width: 32; height: 4; radius: 2 ;rotation: 30 }
        Rectangle { id: line2; x: -14; y: 14; width: 32; height: 4; radius: 2 ;rotation: 90 }
        Rectangle { id: line3; x: -1; y: 21; width: 32; height: 4; radius: 2 ;rotation: -30 }
        Rectangle { id: line4; x: 28; y: 14; width: 4; height: 0; radius: 4; anchors.verticalCenter: parent.verticalCenter }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: playMode = !playMode
        onEntered: rootPS.scale = 0.9
        onExited: rootPS.scale = 0.8
    }

    states: [
        State {
            name: "stop"
            when: !playMode

            PropertyChanges {
                target: content
                anchors.horizontalCenterOffset: 0
            }

            PropertyChanges {
                target: line1
                x: 0
                y: 0
                rotation: 0
            }

            PropertyChanges {
                target: line3
                x: 0
                y: 28
                rotation: 0
            }

            PropertyChanges {
                target: line4
                height: 32
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "stop"
            reversible: true
            NumberAnimation {
                properties: "x, y, height, rotation, anchors.horizontalCenterOffset"
                duration: 80
            }
        }
    ]
}
