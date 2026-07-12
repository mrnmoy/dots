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

        implicitWidth: 380
        implicitHeight: Math.max(1, content.implicitHeight)
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: content
            implicitWidth: parent.width
            spacing: 8

            Repeater {
                model: NotificationService.onScreenNotifications
                delegate: NotificationCard {
                    id: card
                    color: "#0fffffff"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60

                    required property int index

                    Timer {
                        // running: modelData.urgency !== NotificationUrgency.Critical
                        running: true
                        interval: 5000
                        onTriggered: NotificationService.onScreenNotifications.remove(card.index)
                    }

                    onDismiss: {
                        NotificationService.dismiss(index);
                    }
                }
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

                RowLayout {
                    Layout.fillWidth: true
                    implicitHeight: 60

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
                    // model: history
                    model: NotificationService.trackedNotifications
                    // }
                    delegate: Item {
                        id: card

                        implicitWidth: parent.width
                        // anchors {
                        //     left: parent.left
                        //     right: parent.right
                        // }
                        // implicitHeight: card.implicitHeight
                        implicitHeight: 60

                        required property var modelData

                        NotificationCard {
                            anchors.fill: parent
                            modelData: card.modelData
                            onDismiss: modelData.dismiss()
                        }
                    }
                }
            }
        }
    }
}
