import Quickshell

Singleton {
    property bool osd: false
    property bool launcher
    property bool controlcenter
    property bool help
    onOsdChanged: console.log("launcher state changed to ", osd.toString())
}
