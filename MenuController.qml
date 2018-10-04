import QtQuick 2.7
import QtQuick.Controls 2.1

Item {
    id: rootMenu
    width: 364
    height: 744
    clip: true

    Rectangle {
        id: background
        width: menuButton.width
        height: menuButton.height
        color: "#000000"
        opacity: 0.75
        radius: 6
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        PlayStop {
            id: playStopButton
            y: 48
            onPlayModeChanged: concentricCircles.isPlaying = !playMode
        }

        Label_ {
            id: counterLabel
            width: getPaintedWidth()
            text: concentricCircles.counter.toString()
            textHorizontalAlignment: Text.AlignRight
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 12
        }

        Item {
            id: circleSelectionContainer
            width: parent.width
            height: 232

            CIrcleSelection {
                id: circleSelection_1
                y: 20
                anchors.horizontalCenter: parent.horizontalCenter
                onSelectedChanged: setSelection()
            }

            CIrcleSelection {
                id: circleSelection_2
                y: 84
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -64
                onSelectedChanged: setSelection()
            }

            CIrcleSelection {
                id: circleSelection_3
                y: 84
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 64
                onSelectedChanged: setSelection()
            }

            CIrcleSelection {
                id: circleSelection_4
                y: 148
                anchors.horizontalCenter: parent.horizontalCenter
                onSelectedChanged: setSelection()
            }
        }

        Item {
            id: controller
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: circleSelectionContainer.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 4
            anchors.rightMargin: 4

            TabBar {
                id: tabbar
                width: parent.width
                height: 36
                spacing: 2
                background: Rectangle { anchors.fill: parent; color: "#00000000" }

                Repeater {
                    model: ["Emitters", "General"]
                    Tabutton { text: modelData }
                }
            }

            Item {
                id: swipeViewContainer
                width: parent.width
                anchors.top: tabbar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 2
                anchors.bottomMargin: 2

                SwipeView {
                    id: swipeView
                    anchors.fill: parent
                    interactive: false
                    currentIndex: tabbar.currentIndex
                    onCurrentIndexChanged: if (currentIndex !== tabbar.currentIndex) tabbar.currentIndex = currentIndex

                    EmitterController {
                        id: emitterController
                    }

                    GeneralSettings {
                        id: generalSettings
                    }
                }
            }
        }
    }

    MenuButton {
        id: menuButton
        onActivatedChanged: toggleMenu(activated)
    }

    function toggleMenu(status) {
        if (status) showMenuAnim.start()
        else closeMenuAnim.start()
    }

    function setSelection() {
        var selection = [
                    circleSelection_1.selected,
                    circleSelection_2.selected,
                    circleSelection_3.selected,
                    circleSelection_4.selected
                ]

        concentricCircles.setCircleSelection(selection)
    }

    function setSelectionSettings(settings) {
        var selections = [circleSelection_1, circleSelection_2, circleSelection_3, circleSelection_4]

        for (var index = 0; index < settings.length; index++) {
            var setting = settings[index]
            selections[setting.index].shape = setting.shape
            selections[setting.index].reversed = setting.reversed
        }
    }

    SequentialAnimation {
        id: showMenuAnim
        NumberAnimation { target: background; property: "width"; from: menuButton.width; to: rootMenu.width; duration: 60; easing.type: Easing.InOutQuad }
        NumberAnimation { target: background; property: "height"; from: menuButton.height; to: rootMenu.height; duration: 140 ; easing.type: Easing.InOutQuad }
        OpacityAnimator { target: content; from: 0; to: 1; duration: 80 }
    }

    SequentialAnimation {
        id: closeMenuAnim
        OpacityAnimator { target: content; from: 1; to: 0; duration: 80 }
        ParallelAnimation {
            NumberAnimation { target: background; property: "height"; from: rootMenu.height; to: menuButton.height; duration: 120 ; easing.type: Easing.InOutQuad }
            NumberAnimation { target: background; property: "width"; from: rootMenu.width; to: menuButton.width; duration: 80; easing.type: Easing.InOutQuad }
        }
    }
}
