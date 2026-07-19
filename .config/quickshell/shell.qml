import QtQuick
import Quickshell
import "./modules/bar"
import "./modules/notification"
import "./modules/controlcenter"
import "./modules/launcher"
import "./modules/clipboard"
import "./modules/help"
import "./modules/osd"
import "./modules"

ShellRoot {
    id: root

    // BarWindow {}
    Bar {}

    LauncherWindow {}
    ControlCenterWindow {}
    NotificationWindow {}
    OsdWindow {}
    HelpWindow {}
    ClipboardWindow {}

    Shortcuts {}
}
