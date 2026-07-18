import QtQuick
import Quickshell
import "./modules/bar"
import "./modules/notification"
import "./modules/controlcenter"
import "./modules/launcher"
import "./modules/help"
import "./modules/osd"
import "./modules"

ShellRoot {
    id: root

    BarWindow {}

    LauncherWindow {}
    ControlCenterWindow {}
    NotificationWindow {}
    OsdWindow {}
    HelpWindow {}

    Shortcuts {}
}
