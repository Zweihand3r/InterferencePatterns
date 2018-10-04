import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: windowWidth
    height: windowHeight
    title: qsTr("Interference")

    property int windowWidth: 1366
    property int windowHeight: 768

    ConcentricCircles {
        id: concentricCircles
    }

    MenuController {
        id: menuController
        x: 12
        y: 12
    }

    Prep {

    }
}
