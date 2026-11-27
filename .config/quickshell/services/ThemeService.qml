pragma Singleton

import QtCore
import QtQuick
import Quickshell
import Quickshell.Io
import "../config"

// import "file:///home/mrinmoy/.config/themes"

Singleton {
    id: root

    // readonly property string homeDir: StandardPaths.standardLocations(StandardPaths.HomeLocation).toString().split("://")[1]

    // readonly property var colors: Colors
    // readonly property alias colors: qmlcolors.item
    readonly property var colors: JSON.parse(colorsFile.data()).colors

    FileView {
        id: colorsFile
        path: `${Quickshell.env("HOME")}/.config/themes/colors.json`
        watchChanges: true
        onFileChanged: reload()
        onDataChanged: console.log("jsoncolors: ", data())
    }

    // Loader {
    //     id: qmlcolors
    //     source: "file://" + Quickshell.env("HOME") + "/.config/themes/colors-quickshell.qml"
    // }

    // property var colors: {
    //     console.log(qmlcolors.item.wallpaper);
    //     var clrs = colorsFile.text().trim().split("\n");
    //     return {
    //         // primary: clrs[13]
    //         // primary: clrs[4]
    //         primary: clrs[11]
    //     };
    // }

    // FileView {
    //     id: colorsFile
    //     path: `${Quickshell.env("HOME")}/.config/themes/colors`
    //     blockLoading: true
    //     watchChanges: true
    //     onFileChanged: reload()
    // }

    function set(path, wallpaper = true, tmp = false): void {
        Quickshell.execDetached(["/bin/sh", "-c", `${Quickshell.shellDir}/scripts/set-wallpaper-colors.sh -i ${path} -m dark${wallpaper ? " -w" : ""}${Config.appearence.dynamicColors !== "none" ? " -c" : ""}${tmp ? " -t" : ""}`]);
    }
}
