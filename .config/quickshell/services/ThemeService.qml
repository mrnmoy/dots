pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import "../config"

Singleton {
    id: root

    // readonly property var colors: {
    //     if (Config.appearence.dynamicColors === "auto") {
    //         return MprisService.player.colors || WallpaperService.colors;
    //     } else if (Config.appearence.dynamicColors === "wallpaper") {
    //         return WallpaperService.colors;
    //     } else if (Config.appearence.dynamicColors === "media") {
    //         return MprisService.player.colors;
    //     } else {
    //         return {
    //             primary: "red"
    //         };
    //     }
    // }

    property var colors: undefined

    FileView {
        id: colorsFile
        path: ("/home/mrinmoy/.config/themes/colors")
        // blockLoading: true
        watchChanges: true
        onFileChanged: reload()
        onTextChanged: {
            var clrs = text().trim().split("\n");
            root.colors = {
                // primary: clrs[13]
                primary: clrs[4]
            };
        }
    }
}
