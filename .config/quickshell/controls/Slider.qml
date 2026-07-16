import QtQuick
import QtQuick.Controls

Slider {
    id: root

    property string icon: ""
    property color bgColor: "#0fffffff"
    property color handleColor: "#ff9933"

    from: 0
    to: 100
    value: 0
    stepSize: 1
    snapMode: Slider.NoSnap
    // snapMode: Slider.SnapOnRelease

    background: Rectangle {
        id: bg
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 36
        radius: 20
        color: root.bgColor
    }

    handle: Rectangle {
        id: hndl
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - (height / 2)
        width: bg.height
        height: width
        radius: width / 2
        color: root.handleColor

        Text {
            anchors.centerIn: parent
            visible: text !== ""
            text: root.icon
            color: "#ffffff"
            font.pixelSize: 24
        }
    }

    Rectangle {
        z: -1
        anchors.left: bg.left
        anchors.right: hndl.right
        height: bg.height
        color: root.handleColor
        radius: 20
    }
}
