import Quickshell

Singleton {
    property bool osd
    property bool launcher: false
    property bool controlcenter
    property bool help
    onLauncherChanged: console.log("launcher state changed to ", launcher.toString())
}
