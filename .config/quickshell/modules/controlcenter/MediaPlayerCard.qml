import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Rectangle {
    id: root

    required property MprisPlayer modelData
    required property int index

    implicitWidth: parent.width
    implicitHeight: 100
    radius: 20
    color: "#0fffffff"

    RowLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Rectangle {
            Layout.fillHeight: true
            implicitWidth: height
            // Layout.margins: 8
            radius: 20
            clip: true
            color: "#0fffffff"

            Image {
                id: art
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: modelData.trackArtUri
                visible: status === Image.Ready
            }

            Text {
                visible: !art.visible
                text: "󰂚"
                anchors.centerIn: parent
                color: "#ffffff"
                font.pixelSize: 20
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            // Layout.alignment: Qt.AlignVCenter
            spacing: 0

            // Text {
            //     text: root.modelData.appName || "Unknown"
            //
            //     color: "#ffffff"
            //     font.pixelSize: 12
            // }
            //
            // Text {
            //     id: time
            //     text: formatTime(root.modelData.time)
            //
            //     color: "#ffffff"
            //     font.pixelSize: 10
            //
            //     Timer {
            //         // running: true
            //         running: root.visible
            //         interval: 60000
            //         repeat: true
            //         // triggeredOnStart: true
            //         triggeredOnStart: false
            //
            //         onTriggered: time.text = formatTime(root.modelData.time)
            //     }
            // }
        }
    }
}
