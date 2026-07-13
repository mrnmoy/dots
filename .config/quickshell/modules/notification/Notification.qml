import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import "../../components"
import "../../services"

Scope {
    id: root

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 30 + 12
            right: 12
        }

        implicitWidth: 320
        // implicitHeight: 640
        // implicitHeight: content.implicitHeight
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        ListView {
            id: content
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            // anchors.fill: parent
            spacing: 8
            model: NotificationService.onScreenNotifications

            delegate: NotificationCard {
                id: card

                required property int index

                Timer {
                    running: !mouseArea.containsMouse
                    interval: 5000
                    onTriggered: NotificationService.onScreenNotifications.remove(card.index)
                }

                onDismiss: {
                    NotificationService.dismiss(index);
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    // Notification Center
    PanelWindow {
        visible: NotificationService.centerOpen
        anchors {
            top: true
            right: true
        }
        margins {
            top: 30 + 8
            right: 8
        }

        implicitWidth: 320
        implicitHeight: 640
        // implicitHeight: centerCol.implicitHeight + 24
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        Rectangle {
            anchors.fill: parent
            // anchors.margins: 8
            radius: 8
            color: "#01000000"
            border.width: 2
            border.color: "#0fffffff"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                RowLayout {
                    Layout.fillWidth: true
                    implicitHeight: 20

                    Text {
                        Layout.fillWidth: true
                        text: "Notifications"
                        color: "orange"
                        // font.family: Config.fontFamily
                        // font.pixelSize: Config.fontSize
                        font.pixelSize: 20
                        font.bold: true
                        elide: Text.ElideRight
                    }

                    BarButton {
                        icon: "󰎟"
                        onClicked: NotificationService.dismissAll()
                    }
                }

                ListView {
                    id: trackedNotifications
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 8
                    model: NotificationService.trackedNotifications

                    delegate: NotificationCard {
                        onDismiss: modelData.dismiss()
                    }
                }
            }
        }
    }
}
