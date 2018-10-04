import QtQuick 2.7

Item {
    id: rootMB
    width: 48
    height: 48

    property bool activated: false

    Item {
        id: content
        width: 32
        height: 32
        anchors.centerIn: parent
        Behavior on scale { ScaleAnimator { duration: 80 }}

        Rectangle { id: line1; y: 4; width: parent.width; height: 4; radius: 2 }
        Rectangle { id: line2; y: 14; width: parent.width; height: 4; radius: 2 }
        Rectangle { id: line3; y: 24; width: parent.width; height: 4; radius: 2 }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: content.scale = 1.1
        onExited: content.scale = 1
        onClicked: activated = !activated
    }

    states: [
        State {
            name: "active"
            when: activated
            PropertyChanges { target: line2; opacity: 0 }
            PropertyChanges { target: line1; x: 0; y: 14; rotation: 45 }
            PropertyChanges { target: line3; x: 0; y: 14; rotation: -45 }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "active"
            reversible: true
            NumberAnimation { properties: "x, y, rotation, opacity"; duration: 120 }
        }
    ]
}
