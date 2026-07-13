import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import "../../components"

Rectangle {
    id: root

    required property var modelData

    signal dismiss

    implicitWidth: parent.width
    implicitHeight: 100
    radius: 16
    // color: "#01000000"
    color: modelData.urgency === NotificationUrgency.Critical ? "#0fff0000" : "#0fffffff"
    // border.width: 2
    // border.color: modelData.urgency === NotificationUrgency.Critical ? "#ff0000" : "#0fffffff"

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        RowLayout {
            Layout.fillWidth: true
            implicitHeight: 16

            Image {
                id: appIcon
                visible: root.modelData.image !== "" || source.toString() !== ""
                source: root.modelData.appIcon || ""

                Layout.preferredWidth: 16
                Layout.preferredHeight: 16
                // Layout.alignment: Qt.AlignTop
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                visible: !appIcon.visible
                radius: 99
                color: "#0fffffff"
                implicitWidth: 24
                implicitHeight: 24

                Text {
                    text: "󰂚"
                    anchors.centerIn: parent

                    color: "#ffffff"
                    font.pixelSize: 16
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                implicitHeight: 24
                spacing: 0

                Text {
                    text: root.modelData.appName || "Unknown"

                    color: "#ffffff"
                    font.pixelSize: 12
                }

                Text {
                    visible: text !== ""
                    // text: root.modelData.time
                    text: formatTime(root.modelData.time)

                    // Layout.alignment: Qt.AlignRight
                    color: "#ffffff"
                    font.pixelSize: 10
                }
            }
        }

        RowLayout {
            spacing: 8

            Image {
                visible: source.toString() !== ""
                source: root.modelData.image || root.modelData.appIcon || ""

                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.alignment: Qt.AlignTop
                fillMode: Image.PreserveAspectFit
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 2

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 6

                    Text {
                        text: root.modelData.summary

                        Layout.fillWidth: true
                        color: "orange"
                        // font.family: Config.fontFamily
                        // font.pixelSize: Config.fontSize
                        font.pixelSize: 16
                        font.bold: true
                        elide: Text.ElideRight
                    }

                    BarButton {
                        icon: ""
                        onClicked: dismiss()
                    }
                }

                Text {
                    visible: text !== ""
                    text: root.modelData.body

                    Layout.fillWidth: true
                    color: "#ffffff"
                    // font.family: Config.fontFamily
                    // font.pixelSize: Config.fontSize - 1
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    function formatTime(date: Date): string {
        switch (date.getHours()) {
            case 0: return "just now";
            break;
        }
        return date.getHours();
    }
}
