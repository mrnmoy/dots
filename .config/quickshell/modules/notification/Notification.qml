import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import "../../components"
import "../../services"

Scope {
    id: root

    property bool centerOpen: false

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 30 + 12
            right: 12
        }

        implicitWidth: 380
        implicitHeight: Math.max(1, content.implicitHeight)
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: content
            implicitWidth: parent.width
            spacing: 8

            Repeater {
                model: NotificationService.trackedNotifications
                delegate: NotificationCard {

                    Timer {
                        running: modelData.urgency !== NotificationUrgency.Critical
                        interval: 5000
                        onTriggered: modelData.dismiss()
                    }

                    onDismiss: modelData.dismiss()
                }
            }
        }
    }

    // Notification Center
    PanelWindow {
        visible: root.centerOpen
        anchors {
            top: true
            right: true
        }
        margins {
            top: 30 + 12
            right: 12
        }

        implicitWidth: 380
        // implicitHeight: centerCol.implicitHeight + 24
        implicitHeight: 600
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        Rectangle {
            anchors.fill: parent
            anchors.margins: 8
            radius: 8
            color: "#01000000"
            border.width: 2
            border.color: "#0fffffff"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                // RowLayout {
                //     Layout.fillWidth: true
                //     implicitHeight: 60
                //
                //     Text {
                //         Layout.fillWidth: true
                //         text: "Notifications"
                //         color: "orange"
                //         // font.family: Config.fontFamily
                //         // font.pixelSize: Config.fontSize
                //         font.pixelSize: 20
                //         font.bold: true
                //         elide: Text.ElideRight
                //     }
                //
                //     BarButton {
                //         icon: "󰎟"
                //         // contentItem: Text {
                //         //     text: "Clear All"
                //         //     color: "red"
                //         //     font.bold: true
                //         // }
                //         onClicked: NotificationService.clearHistory()
                //     }
                // }

                ListView {
                    id: listView
                    // anchors.fill: parent
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 8
                    // model: history
                    model: NotificationService.history
                    header: RowLayout {
                        implicitWidth: parent.width
                        // implicitHeight: 40

                        Text {
                            Layout.fillWidth: true
                            text: "Notifications"
                            color: "orange"
                            // font.family: Config.fontFamily
                            // font.pixelSize: Config.fontSize
                            font.pixelSize: 20
                            font.bold: true
                        }

                        BarButton {
                            icon: "󰎟"
                            onClicked: NotificationService.clearHistory()
                        }
                    }
                    delegate: Item {
                        NotificationCard {
                            modelData: model
                            // onDismiss: history.remove(index)
                            onDismiss: NotificationService.removeHistory(index)
                        }
                    }
                }
            }
        }
    }

    GlobalShortcut {
        name: "controls_center"
        description: "Controls Center"

        onPressed: {
            root.centerOpen = !root.centerOpen;
        }
    }
}
