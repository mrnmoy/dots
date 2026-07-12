import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "../../components"

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    margins.top: 30

    // implicitHeight: content.implicitHeight + 24
    // color: "transparent"
    color: "#01000000"
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
        id: content

        anchors.centerIn: parent
        implicitWidth: 480
        implicitHeight: 640
        anchors.margins: 8
        radius: 16
        color: "#01000000"
        border.width: 2
        border.color: "#0fffffff"

        ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.fillWidth: true
                implicitHeight: 60

                Text {
                    text: "🔍"
                }

                TextField {}
            }
        }
    }
}
