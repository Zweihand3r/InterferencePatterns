import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    id: root
    width: typeLabel.width + previewList.width + (previewModel.count > 0 ? 4 : 0)
    height: 36

    property color activeColor: "#FFFFFF"
    property int selectedIndex: 0

    signal previewSelected(color color)

    Label_ {
        id: typeLabel
        text: previewModel.count > 2 ? "Gradient" : "Color"
        width: getPaintedWidth()
    }

    ListModel {
        id: previewModel
        ListElement { isEmpty: false; isSelected: true; saved_color: "#000000" }
        ListElement { isEmpty: true; isSelected: false; saved_color: "#000000" }
    }

    ListView {
        id: previewList
        width: 40 * previewModel.count
        height: 36
        orientation: ListView.Horizontal
        anchors.left: typeLabel.right
        anchors.leftMargin: 8
        spacing: 4
        model: previewModel

        delegate: Component {
            id: leDelegate

            Item {
                id: previewDele
                width: 36
                height: 36
                scale: empty ? 0.84 : 1
                Behavior on scale { ScaleAnimator { duration: 120 } }

                property bool empty: isEmpty
                property bool selected: isSelected
                property color savedColor: saved_color

                Rectangle {
                    anchors.fill: parent
                    radius: width / 2
                    color: "transparent"
                    border.width: 2
                    border.color: "#FFFFFF"
                    opacity: previewDele.empty ? 1 : (previewDele.selected ? 1 : 0)
                    Behavior on opacity { OpacityAnimator { duration: 120 } }
                }

                Rectangle { // Preview
                    width: 24
                    height: 24
                    anchors.centerIn: parent
                    color: previewDele.savedColor
                    radius: width / 2
                    scale: previewDele.empty ? 0 : 1
                    Behavior on scale { ScaleAnimator { duration: 120 } }
                }

                Item {
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    visible: previewDele.empty

                    Rectangle { width: parent.width; height: 2; anchors.verticalCenter: parent.verticalCenter }
                    Rectangle { width: 2; height: parent.height; anchors.horizontalCenter: parent.horizontalCenter }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: previewDele.clickAction(index)
                }

                function clickAction(index) {
                    if (empty) {
                        previewModel.setProperty(index, "isEmpty", false)
                        addEmptyPreview()
                    }

                    setSelection(index)
                }
            }
        }
    }

    function setSelection(index) {
        var savedColor = previewModel.get(index).saved_color

        for (var x = 0; x < previewModel.count; x++) {
            previewModel.setProperty(x, "isSelected", x === index)
        }

        selectedIndex = index
        previewSelected(savedColor)
    }

    function addEmptyPreview() {
        if (previewModel.count < 5) {
            var index = previewModel.count
            previewModel.append({"isEmpty":true, "isSelected": false, "saved_color": "#000000"})
        }
    }

    function setSavedColor() {
        previewModel.setProperty(selectedIndex, "saved_color", activeColor.toString())
    }

    function reset() {
        previewModel.set(0, { "isSelected": true, "saved_color": "#000000" })
        previewModel.remove(1, previewModel.count - 1)
        previewModel.append({"isEmpty":true, "isSelected": false, "saved_color": "#000000"})

        selectedIndex = 0
    }

    function getGradientColors() {
        var gradientLimits = []

        for (var index = 0; index < previewModel.count; index++) {
            if (!previewModel.get(index).isEmpty) {
                gradientLimits.push(previewModel.get(index).saved_color)
            }
        }

        if (gradientLimits.length < 2) {
            return gradientLimits
        }
        else {
            var gradients = []

            for (index = 0; index < gradientLimits.length; index++) {
                var gradient0 = gradientLimits[index]
                var gradient1 = index === gradientLimits.length - 1 ? gradientLimits[0] : gradientLimits[index + 1]

                var transitoryArray = generateGradient(gradient0, gradient1, 32)

                transitoryArray.forEach(function(color) {
                    gradients.push(color)
                })
            }

            return gradients
        }
    }

    function generateGradient(gradient0, gradient1, steps) {
        var colorArray = []

        var red1 = helpers.getRed(gradient0)
        var red2 = helpers.getRed(gradient1)
        var green1 = helpers.getGreen(gradient0)
        var green2 = helpers.getGreen(gradient1)
        var blue1 = helpers.getBlue(gradient0)
        var blue2 = helpers.getBlue(gradient1)

        var redStep = ((red2 - red1) / steps)
        var greenStep = ((green2 - green1) / steps)
        var blueStep = ((blue2 - blue1) / steps)

        for (var index = 0; index <= steps; index++) {
            var red = parseInt(red1 + redStep * index).toString(16)
            var green = parseInt(green1 + greenStep * index).toString(16)
            var blue = parseInt(blue1 + blueStep * index).toString(16)

            red = red.length < 2 ? "0" + red : red
            green = green.length < 2 ? "0" + green : green
            blue = blue.length < 2 ? "0" + blue : blue

            var color = "#" + red + green + blue

            colorArray.push(color)
        }

        return colorArray
    }
}
