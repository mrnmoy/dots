pragma Singleton

import QtQuick
import Quickshell
import "../services"

Singleton {
    id: root

    readonly property var launcher: ({
            favourites: ["Alacritty", "Zen Browser", "thunar",]
        })

    readonly property var onScreenNotification: ({
            maxLength: 3,
            timeout: 5000
        })

    readonly property var appearence: ({
            theme: "auto" // "auto" | "light" | "dark"
            ,
            dynamicColors: "auto" // "auto" | "wallpaper" | "media" | "none"
            ,
            dynamicWallpaper: true,
            // wallpaperBlur:, 20 // TODO
            animationDuration: 250,
            timeout: 0
        })

    readonly property var media: ({
            lyricsEnabled: true,
            blacklist: ["Mozilla zen"]
        })
}
