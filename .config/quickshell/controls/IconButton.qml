import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    required property string icon
    property int size: 16
    property string desc: ""
    property color iconColor: "#ffffff"
    property color hoveredIconColor: "#ff9933"
    readonly property bool hovered: mouseArea.containsMouse

    signal clicked

    implicitWidth: size + 16
    implicitHeight: implicitWidth
    radius: size

    color: "transparent"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

    Text {
        visible: root.icon !== ""
        text: root.icon
        font.pixelSize: 24
        color: (root.enabled && root.hovered) ? root.hoveredIconColor : root.iconColor
        opacity: !root.enabled ? 0.5 : 1

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }
}
