import QtQuick 2.7

Item {
    id: control
    width: 100
    height: 36

    property string firstItem: "First"
    property string secondItem: "Second"
    property int index: 0

    Rectangle {
        id: firstSegment
        width: parent.width / 2 + 1
        height: parent.height
        color: "#00000000"
        border.width: 2
        border.color: "#FFFFFF"

        Rectangle {
            width: parent.width - 8
            height: parent.height - 8
            opacity: index === 0
            anchors.centerIn: parent
            Behavior on opacity { OpacityAnimator { duration: 120 }}
        }

        Label_ {
            id: firstSegmentLabel
            anchors.centerIn: parent
            text: firstItem
            fontSize: 15
            textColor: index === 0 ? "#000000" : "#FFFFFF"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: index = 0
        }
    }

    Rectangle {
        id: secSegment
        x: parent.width / 2 - 1
        width: parent.width / 2 + 1
        height: parent.height
        color: "#00000000"
        border.width: 2
        border.color: "#FFFFFF"

        Rectangle {
            width: parent.width - 8
            height: parent.height - 8
            opacity: index === 1
            anchors.centerIn: parent
            Behavior on opacity { OpacityAnimator { duration: 120 }}
        }

        Label_ {
            id: secSegmentLabel
            anchors.centerIn: parent
            text: secondItem
            fontSize: 15
            textColor: index === 1 ? "#000000" : "#FFFFFF"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: index = 1
        }
    }
}
