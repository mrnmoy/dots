pragma Singleton

import QtCore
import QtQuick
import Quickshell
import Quickshell.Io

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

    function refreshColors(path, temp = false): void {
        var ogWal;
        if (temp) {
            hyprlandColorsFile.reload();
            ogWal = hyprlandColorsFile.text().split("\n")[0].split("=")[1].trim();
            console.log(ogWal);
        }

        refreshColorsProc.path = path;
        refreshColorsProc.running = true;
    }

    FileView {
        id: hyprlandColorsFile
        path: `${root.homeDir}/.config/themes/colors-hyprland.conf`
        blockLoading: true
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
        command: ["/bin/sh", "-c", `cwal -i ${path} -o ${root.homeDir}/.config/themes`]
    }
}
