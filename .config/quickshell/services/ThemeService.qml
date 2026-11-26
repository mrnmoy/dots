pragma Singleton

import QtCore
import QtQuick
import Quickshell
import Quickshell.Io
import "../config"

Singleton {
    id: root

    readonly property string homeDir: StandardPaths.standardLocations(StandardPaths.HomeLocation).toString().split("://")[1]

    property var colors: {
        var clrs = colorsFile.text().trim().split("\n");
        return {
            // primary: clrs[13]
            // primary: clrs[4]
            primary: clrs[11]
        };
    }

    function refreshColors(path, tmp = false): void {
        // refreshColorsProc.path = path;
        // refreshColorsProc.running = true;

        Quickshell.execDetached(["/bin/sh", "-c", `${Quickshell.shellDir}/scripts/refresh-colors.sh ${path} ${tmp && "tmp"}`]);
    }

    FileView {
        id: colorsFile
        path: `${root.homeDir}/.config/themes/colors`
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    Process {
        id: refreshColorsProc
        property string path: ""
        // command: ["/bin/sh", "-c", `cwal -i ${path} -o ${root.homeDir}/.config/themes`]
        command: ["/bin/sh", "-c", `${Quickshell.shellDir}/scripts/refresh-colors.sh ${path} ${Config.appearence.dynamicWallpaper && "tmp"}`]
    }
}
