import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import "../../components"

Rectangle {
    id: root

    required property var modelData

    signal dismiss

    // anchors.fill: parent
    // Layout.fillWidth: true
    // Layout.preferredHeight: 60
    // Layout.preferredHeight: layout.implicitHeight + 20
    radius: 8
    color: "#01000000"
    border.width: 2
    border.color: modelData.urgency === NotificationUrgency.Critical ? "#ff0000" : "#0fffffff"

    RowLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Image {
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.alignment: Qt.AlignTop
            fillMode: Image.PreserveAspectFit
            // visible: source.toString() !== ""
            source: root.modelData.image || root.modelData.appIcon || ""
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            RowLayout {
                Layout.fillWidth: true
                spacing: 6

                Text {
                    Layout.fillWidth: true
                    text: root.modelData.summary
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
                Layout.fillWidth: true
                visible: text !== ""
                text: root.modelData.body
                color: "#ffffff"
                // font.family: Config.fontFamily
                // font.pixelSize: Config.fontSize - 1
                font.pixelSize: 14
                wrapMode: Text.WordWrap
            }

            Text {
                visible: root.modelData.appName !== ""
                Layout.fillWidth: true
                text: root.modelData.appName
                color: "#ffffff"
                // font.family: Config.fontFamily
                // font.pixelSize: Config.fontSize - 3
                font.pixelSize: 12
                wrapMode: Text.WordWrap
            }
        }
    }
}
