import QtQuick 2.7
import QtQuick.Layouts 1.3

Item {
    id: root
    width: 356
    height: 512

    RowLayout {
        y: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Button_ {
            text: "Reset"
            font.pixelSize: 17
            Layout.preferredWidth: 120
            Layout.preferredHeight: 32
            onClicked: resetAction()
        }

        Button_ {
            text: "Apply"
            font.pixelSize: 17
            Layout.preferredWidth: 120
            Layout.preferredHeight: 32
            onClicked: applyAction()
        }
    }

    ColumnLayout {
        y: 76
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8

        RowLayout {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Label_ {
                text: "Resolution"
            }

            DropdownButton {
                id: resolutionDropdown
                Layout.preferredWidth: 164
                Layout.preferredHeight: 32
                model: ["1366 x 768", "1280 x 768", "1024 x 768", "768 x 768", "1920 x 1080"]
            }
        }

        RowLayout {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter

            Label_ {
                text: "Background"
                Layout.preferredWidth: getPaintedWidth()
            }

            Rectangle {
                id: colorPreview
                width: 24
                height: 24
                radius: 14
                color: "#FFFFFF"
            }
        }

        RowLayout {
            id: colorPicker

            ColorDial {
                id: redDial
                value: 1
                handleColor: "#ed5136"
                Layout.preferredWidth: 96
                Layout.preferredHeight: 96
                onLiveValueChanged: colorPicker.setPreviewColor()
            }

            ColorDial {
                id: greenDial
                value: 1
                handleColor: "#9ded35"
                Layout.preferredWidth: 96
                Layout.preferredHeight: 96
                onLiveValueChanged: colorPicker.setPreviewColor()
            }

            ColorDial {
                id: blueDial
                handleColor: "#35afed"
                value: 1
                Layout.preferredWidth: 96
                Layout.preferredHeight: 96
                onLiveValueChanged: colorPicker.setPreviewColor()
            }

            function getSelectedColor() {
                return Qt.rgba(redDial.liveValue, greenDial.liveValue, blueDial.liveValue, 1)
            }

            function setPreviewColor() {
                colorPreview.color = getSelectedColor()
            }
        }
    }

    function applyAction() {
        var settings = {
            "bgColor": colorPicker.getSelectedColor()
        }

        var resValues = resolutionDropdown.currentText.split(" ")
        windowWidth = parseInt(resValues[0])
        windowHeight = parseInt(resValues[2])

        concentricCircles.setGeneralSettings(settings)
    }

    function resetAction() {
        redDial.value = 1
        greenDial.value = 1
        blueDial.value = 1
    }
}
