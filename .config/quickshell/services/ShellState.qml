import QtQuick
import Quickshell

Singleton {
    property ShellRoot shellRoot

    Variants {
        id: components
        model: Screens.screens
        Components {}
    }

    component Components: QtObject {
        property bool osd: false
        property bool launcher
        property bool controlcenter
        property bool help
        onOsdChanged: console.log("launcher state changed to ", osd.toString())
    }

    component ComponentRef: QtObject {
        required property ShellScreen screen

        required property var component

        readonly property QtObject target: ShellState.componentsFor(screen)
    }
}
