pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import "../config"

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

    FileView {
        id: colorsFile
        path: ("/home/mrinmoy/.config/themes/colors")
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }
}
