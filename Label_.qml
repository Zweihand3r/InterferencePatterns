import QtQuick 2.0

Item {
    id: control
    width: 100
    height: 36

    property string text: "Text here"
    property color textColor: "#FFFFFF"
    property real fontSize: 21
    property int textHorizontalAlignment: Text.AlignHCenter

    Text {
        id: textItem
        anchors.fill: parent
        text: control.text
        color: textColor
        font.pixelSize: fontSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: textHorizontalAlignment

        Behavior on color { ColorAnimation { duration: 120 } }
    }

    function getPaintedWidth() {
        return textItem.paintedWidth
    }
}
