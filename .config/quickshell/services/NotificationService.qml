pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property ListModel history: ListModel {}
    readonly property ObjectModel trackedNotifications: server.trackedNotifications

    function removeHistory(index: int): void {
        history.remove(index);
    }
    function clearHistory(): void {
        history.clear();
    }

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            n.tracked = true;
            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            });
        }
    }
}
