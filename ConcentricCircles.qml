import QtQuick 2.7
import QtQuick.Controls 2.0

import Shape 1.0

Item {
    id: rootCC
    width: windowWidth
    height: windowHeight

    property int counter: 0
    property bool isPlaying: false

    property bool circle1Selected: true
    property bool circle2Selected: true
    property bool circle3Selected: true
    property bool circle4Selected: true

    property bool circle1ReverseCondition: false
    property bool circle2ReverseCondition: false
    property bool circle3ReverseCondition: false
    property bool circle4ReverseCondition: false

    property int circle1EmitCount: 1
    property int circle2EmitCount: 1
    property int circle3EmitCount: 1
    property int circle4EmitCount: 1

    property int circle1GradientIndex: 0
    property int circle2GradientIndex: 0
    property int circle3GradientIndex: 0
    property int circle4GradientIndex: 0

    property var circle1: { "leColor": circle1Gradients[circle1GradientIndex], "borderWidth" : circle1BorderWidth, "speed": circle1Speed, "shape": circle1Shape, "reversed": circle1Reversed }
    property var circle2: { "leColor": circle2Gradients[circle2GradientIndex], "borderWidth" : circle2BorderWidth, "speed": circle2Speed, "shape": circle2Shape, "reversed": circle2Reversed }
    property var circle3: { "leColor": circle3Gradients[circle3GradientIndex], "borderWidth" : circle3BorderWidth, "speed": circle3Speed, "shape": circle3Shape, "reversed": circle3Reversed }
    property var circle4: { "leColor": circle4Gradients[circle4GradientIndex], "borderWidth" : circle4BorderWidth, "speed": circle4Speed, "shape": circle4Shape, "reversed": circle4Reversed }

    property int circle1Shape: Shape.Circle
    property int circle2Shape: Shape.Circle
    property int circle3Shape: Shape.Circle
    property int circle4Shape: Shape.Circle

    property bool circle1Reversed: false
    property bool circle2Reversed: false
    property bool circle3Reversed: false
    property bool circle4Reversed: false

    property int circle1BorderWidth: 8
    property int circle2BorderWidth: 8
    property int circle3BorderWidth: 8
    property int circle4BorderWidth: 8

    property int circle1Speed: 3
    property int circle2Speed: 3
    property int circle3Speed: 3
    property int circle4Speed: 3

    property var circle1Gradients: ["#000000"]
    property var circle2Gradients: ["#000000"]
    property var circle3Gradients: ["#000000"]
    property var circle4Gradients: ["#000000"]

    Rectangle {
        id: bg
        anchors.fill: parent
        Behavior on color { ColorAnimation { duration: 120 } }
    }

    Item {
        id: containerLeft
        width: windowWidth / 2
        height: windowHeight
    }

    Item {
        id: containerRight
        x: windowWidth / 2
        width: windowWidth / 2
        height: windowHeight
    }

    Item {
        id: verticalFrame
        width: windowHeight
        height: windowWidth
        anchors.centerIn: parent

        Item {
            id: containerTop
            width: parent.width
            height: verticalFrame.height / 2
        }

        Item {
            id: containerBottom
            y: verticalFrame.height / 2
            width: parent.width
            height: verticalFrame.height / 2
        }
    }

    Component.onCompleted: concentricTimer.start()

    function drawCircles() {
        var component = Qt.createComponent("Circle.qml")

        if (isPlaying) {
            if (circle1Selected) {
                if (!circle1ReverseCondition && counter % circle1EmitCount === 0) {
                    circle1GradientIndex = circle1GradientIndex < circle1Gradients.length - 1 ? circle1GradientIndex + 1 : 0
                    component.createObject(containerTop, circle1)
                }
                else if (circle1ReverseCondition && counter % circle1EmitCount !== 0) {
                    circle1GradientIndex = circle1GradientIndex < circle1Gradients.length - 1 ? circle1GradientIndex + 1 : 0
                    component.createObject(containerTop, circle1)
                }
            }

            if (circle2Selected) {
                if (!circle2ReverseCondition && counter % circle2EmitCount === 0) {
                    circle2GradientIndex = circle2GradientIndex < circle2Gradients.length - 1 ? circle2GradientIndex + 1 : 0
                    component.createObject(containerLeft, circle2)
                }
                else if (circle2ReverseCondition && counter % circle2EmitCount !== 0) {
                    circle2GradientIndex = circle2GradientIndex < circle2Gradients.length - 1 ? circle2GradientIndex + 1 : 0
                    component.createObject(containerLeft, circle2)
                }
            }

            if (circle3Selected) {
                if (!circle3ReverseCondition && counter % circle3EmitCount === 0) {
                    circle3GradientIndex = circle3GradientIndex < circle3Gradients.length - 1 ? circle3GradientIndex + 1 : 0
                    component.createObject(containerRight, circle3)
                }
                else if (circle3ReverseCondition && counter % circle3EmitCount !== 0) {
                    circle3GradientIndex = circle3GradientIndex < circle3Gradients.length - 1 ? circle3GradientIndex + 1 : 0
                    component.createObject(containerRight, circle3)
                }
            }

            if (circle4Selected) {
                if (!circle4ReverseCondition && counter % circle4EmitCount === 0) {
                    circle4GradientIndex = circle4GradientIndex < circle4Gradients.length - 1 ? circle4GradientIndex + 1 : 0
                    component.createObject(containerBottom, circle4)
                }
                else if (circle4ReverseCondition && counter % circle4EmitCount !== 0) {
                    circle4GradientIndex = circle4GradientIndex < circle4Gradients.length - 1 ? circle4GradientIndex + 1 : 0
                    component.createObject(containerBottom, circle4)
                }
            }

            counter++
        }
    }

    function setCircleSelection(selection) {
        circle1Selected = selection[0]
        circle2Selected = selection[1]
        circle3Selected = selection[2]
        circle4Selected = selection[3]
    }

    function setEmmiterSettings(settings) {
        counter = 0

        if (settings.length > 0) {
            for (var index = 0; index < settings.length; index++) {
                setCircleSettings(settings[index]["index"], settings[index])
            }
        }
    }

    function setCircleSettings(index, setting) {
        circle1GradientIndex = 0
        circle2GradientIndex = 0
        circle3GradientIndex = 0
        circle4GradientIndex = 0

        rootCC["circle" + (index + 1) + "Gradients"] = setting["leColors"]
        rootCC["circle" + (index + 1) + "Shape"] = setting["shape"]
        rootCC["circle" + (index + 1) + "Reversed"] = setting["reversed"]
        rootCC["circle" + (index + 1) + "BorderWidth"] = setting["borderWidth"]
        rootCC["circle" + (index + 1) + "Speed"] = setting["speed"]
        rootCC["circle" + (index + 1) + "ReverseCondition"] = setting["circleReverseCondition"]
        rootCC["circle" + (index + 1) + "EmitCount"] = setting["circleEmitCount"]
    }

    function setGeneralSettings(settings) {
        bg.color = settings["bgColor"]
    }

    Timer {
        id: concentricTimer
        interval: 160
        repeat: true
        onTriggered: drawCircles()
    }
}
