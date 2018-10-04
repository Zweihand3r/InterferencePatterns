import QtQuick 2.7
import QtQuick.Layouts 1.3
import CppHelpers 1.0

Item {
    id: root
    width: 356
    height: 458

    CppHelpers {
        id: helpers
    }

    RowLayout {
        y: 20
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            width: 90
            height: 90

            Radiobutton {
                id: topEmitterIndicator
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Radiobutton {
                id: leftEmitterIndicator
                y: 27
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -27
            }

            Radiobutton {
                id: rightEmitterIndicator
                y: 27
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 27
            }

            Radiobutton {
                id: bottomEmitterIndicator
                y: 54
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        ColumnLayout {
            spacing: 2

            RowLayout {
                spacing: 2

                Button_ {
                    text: "All"
                    Layout.preferredWidth: 80
                    onClicked: setSelectionForAll(true)
                }

                Button_ {
                    text: "None"
                    Layout.preferredWidth: 80
                    onClicked: setSelectionForAll(false)
                }
            }

            RowLayout {
                spacing: 2

                Button_ {
                    text: "Reset"
                    Layout.preferredWidth: 162
                    onClicked: resetAction()
                }

//                Button_ {
//                    text: "Paste"
//                    Layout.preferredWidth: 80
//                }
            }

            Button_ {
                text: "Apply"
                Layout.preferredWidth: 162
                onClicked: applyAction()
            }
        }
    }

    Flickable {
        y: 132
        width: parent.width
        height: 326
        contentHeight: 454
        clip: true

        Item {
            width: 356
            height: 454

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter

                ColorGradientPreview {
                    id: colorGradientPreview
                    anchors.horizontalCenter: parent.horizontalCenter
                    activeColor: "#000000"
                    onPreviewSelected: colorPicker.setDials(color)
                }

                RowLayout {
                    id: colorPicker

                    ColorDial {
                        id: redDial
                        handleColor: "#ed5136"
                        Layout.preferredWidth: 96
                        Layout.preferredHeight: 96
                        onLiveValueChanged: colorPicker.liveValueChange()
                    }

                    ColorDial {
                        id: greenDial
                        handleColor: "#9ded35"
                        Layout.preferredWidth: 96
                        Layout.preferredHeight: 96
                        onLiveValueChanged: colorPicker.liveValueChange()
                    }

                    ColorDial {
                        id: blueDial
                        handleColor: "#35afed"
                        Layout.preferredWidth: 96
                        Layout.preferredHeight: 96
                        onLiveValueChanged: colorPicker.liveValueChange()
                    }

                    function getSelectedColor() {
                        return Qt.rgba(redDial.liveValue, greenDial.liveValue, blueDial.liveValue, 1)
                    }

                    function setPreviewColor() {
                        colorGradientPreview.activeColor = getSelectedColor()
                    }

                    function setDials(color) {
                        redDial.value = helpers.getRed(color) / 255
                        greenDial.value = helpers.getGreen(color) / 255
                        blueDial.value = helpers.getBlue(color) / 255
                    }

                    function liveValueChange() {
                        colorPicker.setPreviewColor()
                        colorGradientPreview.setSavedColor()
                    }
                }
            }

            ColumnLayout {
                y: 162
                anchors.horizontalCenter: parent.horizontalCenter

                Label_ {
                    text: "Emitter Condition:"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                RowLayout {
                    spacing: 8

                    Label_ {
                        text: "Counter"
                        width: getPaintedWidth()
                    }

                    SegmentControl {
                        id: conditionSegmentControl
                        Layout.preferredWidth: 75
                        Layout.preferredHeight: 28
                        firstItem: "=="
                        secondItem: "!="
                    }

                    Label_ {
                        text: "multiple of"
                        Layout.preferredWidth: getPaintedWidth()
                    }

                    NumberSelection {
                        id: numberSelection
                        Layout.maximumWidth: 16
                    }
                }
            }

            ColumnLayout {
                y: 264
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                RowLayout {
                    spacing: 12
                    Layout.preferredWidth: parent.width

                    Label_ {
                        text: "Reversed"
                        Layout.preferredWidth: getPaintedWidth()
                        textHorizontalAlignment: Text.AlignLeft
                    }

                    Radiobutton {
                        id: reversedButton
                        scale: 0.8
                        Layout.alignment: Qt.AlignRight
                    }
                }

                RowLayout {
                    spacing: 12

                    Label_ {
                        text: "Shape"
                        Layout.preferredWidth: 64
                        textHorizontalAlignment: Text.AlignLeft
                    }

                    Slider_Shape {
                        id: shapeSlider
                        Layout.preferredWidth: 228
                    }
                }

                RowLayout {
                    spacing: 12

                    Label_ {
                        text: "Size"
                        Layout.preferredWidth: 64
                        textHorizontalAlignment: Text.AlignLeft
                    }

                    Slider_ {
                        id: sizeSlider
                        from: 2
                        to: 30
                        value: 8
                        Layout.preferredWidth: 228
                    }
                }

                RowLayout {
                    spacing: 12

                    Label_ {
                        text: "Speed"
                        Layout.preferredWidth: 64
                        textHorizontalAlignment: Text.AlignLeft
                    }

                    Slider_ {
                        id: speedSlider
                        from: 1
                        to: 5
                        value: 3
                        Layout.preferredWidth: 228
                    }
                }
            }
        }
    }

    function setSelectionForAll(selection) {
        topEmitterIndicator.selected = selection
        leftEmitterIndicator.selected = selection
        rightEmitterIndicator.selected = selection
        bottomEmitterIndicator.selected = selection
    }

    function applyAction() {
        var settings = []
        var toggles = [topEmitterIndicator, leftEmitterIndicator, rightEmitterIndicator, bottomEmitterIndicator]

        for (var index = 0; index < toggles.length; index++) {
            if (toggles[index].selected) {
                settings.push({
                                  "index": index,
                                  "leColors": colorGradientPreview.getGradientColors(),
                                  "shape": shapeSlider.value,
                                  "reversed": reversedButton.selected,
                                  "borderWidth": sizeSlider.liveValue,
                                  "speed": speedSlider.liveValue,
                                  "circleReverseCondition": (conditionSegmentControl.index === 0 ? false : true),
                                  "circleEmitCount": numberSelection.currentCount
                              })
            }
        }

        setSelectionSettings(settings)
        concentricCircles.setEmmiterSettings(settings)
        colorGradientPreview.getGradientColors()
    }

    function resetAction() {
        redDial.value = 0
        greenDial.value = 0
        blueDial.value = 0
        colorGradientPreview.reset()

        conditionSegmentControl.index = 0
        numberSelection.currentCount = 1

        shapeSlider.reset()
        sizeSlider.value = 8
        speedSlider.value = 3
    }
}
