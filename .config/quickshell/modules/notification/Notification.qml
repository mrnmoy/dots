import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications

Scope {
    id: root

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            console.log("got:", n.summary, "---", n.body);
            n.tracked = true;
        }
    }

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 12
            right: 12
        }

        implicitWidth: 380
        // implicitHeight: Math.max(1, content.implicitHeight)
        // implicitHeight: Math.max(1, content.implicitHeight)
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: content
            implicitWidth: parent.width
            spacing: 8

            Repeater {
                model: server.trackedNotifications
                delegate: Rectangle {
                    id: actionsSupported
                    required property var modelData

                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    // Layout.preferredHeight: layout.implicitHeight + 20
                    radius: 8
                    border.width: 2
                    border.color: modelData.urgency === NotificationUrgency.Critical ? "#ff0000" : "#0fffffff"
                }
            }
        }
    }
}
