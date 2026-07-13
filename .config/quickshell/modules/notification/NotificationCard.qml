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
                    id: time
                    visible: text !== ""
                    // text: root.modelData.time
                    text: formatTime(root.modelData.time)

                    // Layout.alignment: Qt.AlignRight
                    color: "#ffffff"
                    font.pixelSize: 10

                    Timer {
                        // running: true
                        running: root.visible
                        interval: 60000
                        repeat: true
                        // triggeredOnStart: true
                        triggeredOnStart: false

                        onTriggered: time.text = formatTime(root.modelData.time)
                    }
                }
            }

            BarButton {
                icon: ""
                onClicked: dismiss()
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

    function formatTime(date): string {
        const currentDate = new Date();
        // const deltaM = currentDate.getMinutes() - date.getMinutes()
        const deltaT = Math.floor((currentDate.getTime() - date.getTime()) / 60000);
        // console.log("deltaT", deltaT);
        if (deltaT < 1) {
            return "Just now";
        } else if (deltaT < 60) {
            return deltaT + " Min ago";
        } else if (deltaT < (60 * 24)) {
            return (currentDate.getHours() - date.getHours()) + " Hours" + (currentDate.getMinutes() - date.getMinutes()) + " Min ago";
        }
        return date.toDateString();

        // const deltaT = (time - Date.now()) / 60000;
        // if (deltaT < 1) {
        //     return "Just now";
        // } else if (deltaT < 60) {
        //     return deltaT + "Mins ago";
        // } else if (deltaT < (60 * 24)) {
        //     return deltaT / 60 + "Hours" + "Mins ago";
        // }
    }
}
