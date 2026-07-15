import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import "../../components"
import "../../services"
import "../../config"
import "../notification"

PanelWindow {
    id: root

    anchors {
        top: true
        right: true
    }
    // margins {
    // top: 8
    // right: 8
    // }

    visible: NotificationService.onScreenNotificationsModel.count > 0
    implicitWidth: 360
    implicitHeight: content.height + 52
    color: "transparent"

    screen: Quickshell.screens[0]

    // readonly property list<Notification> visibleNotifications: (NotificationService.onScreenNotifications)?.slice(0, Config.onScreenNotification.maxVisible) || []
    // onVisibleNotificationsChanged: console.log("visibleNotifications", JSON.stringify(visibleNotifications))

    MultiEffect {
        source: background
        anchors.fill: background
        maskEnabled: true
        maskSource: mask

        // layer.smooth: true

        maskThresholdMin: 0.5
        maskSpreadAtMin: 1.0
    }

    Rectangle {
        id: background
        anchors.fill: parent
        visible: false
        // smooth: true
        color: "#01000000"
    }

    Shape {
        id: mask
        anchors.fill: background
        antialiasing: true

        visible: false
        layer.enabled: true

        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: "transparent"

            startX: 0
            startY: 0

            PathArc {
                radiusX: 20
                radiusY: 20
                x: 20
                y: 20
            }
            PathLine {
                x: 20
                y: mask.height - 40
            }
            PathArc {
                direction: PathArc.Counterclockwise
                radiusX: 20
                radiusY: 20
                x: 40
                y: mask.height - 20
            }
            PathLine {
                x: mask.width - 20
                y: mask.height - 20
            }
            PathArc {
                radiusX: 20
                radiusY: 20
                x: mask.width
                y: mask.height
            }
            PathLine {
                x: mask.width
                y: 20
            }
            PathArc {
                direction: PathArc.Counterclockwise
                radiusX: 20
                radiusY: 20
                x: mask.width - 20
                y: 0
            }
            PathLine {
                x: 0
                y: 0
            }
        }
    }

    Column {
        id: content
        spacing: 16
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right

            topMargin: 16
            rightMargin: 16
            leftMargin: 36
            bottomMargin: 16
        }

        // move: Transition {
        //     NumberAnimation {
        //         properties: "y"
        //         duration: 150
        //         easing.type: Easing.OutCubic
        //     }
        // }

        Repeater {
            // model: root.visibleNotifications
            // model: NotificationService.onScreenNotifications
            // model: (NotificationService.onScreenNotificationsModel).slice(0, 3)
            model: NotificationService.onScreenNotificationsModel

            // Rectangle {
            //     id: card
            //
            //     required property var modelData
            //     required property int index
            //
            //     implicitWidth: parent.width
            //     implicitHeight: 100
            //     clip: true
            //     radius: 16
            //     color: modelData.urgency === NotificationUrgency.Critical ? "#0fff0000" : "#0fffffff"
            //
            //     Timer {
            //         running: true
            //         interval: 5000
            //         onTriggered: NotificationService.onScreenNotificationsModel.remove(card.index)
            //     }
            // }

            NotificationCard {
                id: card

                Timer {
                    running: true
                    interval: 5000
                    onTriggered: NotificationService.onScreenNotificationsModel.remove(card.index)
                }

                onDismiss: {
                    NotificationService.onScreenNotificationsModel.remove(index);
                    NotificationService.dismiss(modelData.id);
                }
            }
        }
    }
}
