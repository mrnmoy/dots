pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var colors: {
        var clrs = colorsFile.text().trim().split("\n");
        return {
            // primary: clrs[13]
            // primary: clrs[4]
            primary: clrs[11]
        };
    }

    function refreshColors(path): void {
        refreshColorsProc.path = path;
        refreshColorsProc.running = true;
    }

    FileView {
        id: colorsFile
        path: ("/home/mrinmoy/.config/themes/colors")
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    Process {
        id: refreshColorsProc
        property string path: ""
        command: ["/bin/sh", "-c", `cwal -i ${path} -o /home/mrinmoy/.config/themes`]
    }
}
