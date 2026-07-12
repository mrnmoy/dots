import QtQuick
import Quickshell.Hyprland
import "../../components"

BarButton {
    id: root

    active: appMenuPopup.visible
    onClicked: appMenuPopup.visible = !appMenuPopup.visible

    icon: "󰣇"
    // text: "AppMenu"

    AppMenuPopup {
        id: appMenuPopup
        visible: false
    }

    GlobalShortcut {
        name: "app_launcher"
        description: "Application Launcher"

        onPressed: {
            appMenuPopup.visible = !appMenuPopup.visible;
        }
    }
}
