import QtQuick

Rectangle {
    id: root

    property bool active: false
    property Item contentItem: null
    readonly property bool hovered: mouseArea.containsMouse

    signal clicked
    signal rightClicked

    implicitWidth: (contentItem?.implicitWidth ?? 0) + (8 * 2)
    implicitHeight: 20
    radius: height / 2

    color: (active || hovered) ? "#00ff00" : "#0fffffff"

    Behavior on color {
        ColorAnimation {
            duration: 50
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                root.rightClicked();
            else
                root.clicked();
        }
    }
}
