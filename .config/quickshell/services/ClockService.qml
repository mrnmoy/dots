pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
